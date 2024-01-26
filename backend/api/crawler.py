import io
import multiprocessing
from urllib.parse import urlparse

import extruct
import PyPDF2
import scrapy
from scrapy import signals
from scrapy.crawler import CrawlerRunner
from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule
from twisted.internet import reactor
from w3lib.html import replace_escape_chars
from w3lib.url import url_query_cleaner


def process_links(links):
    for link in links:
        link.url = url_query_cleaner(link.url)
        yield link


class PageCrawler(CrawlSpider):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.start_urls = [kwargs.get("start_url")]
        self.allowed_domains = [urlparse(kwargs.get("start_url")).netloc]

    name = "crawler"
    rules = (
        Rule(
            LinkExtractor(),
            process_links=process_links,
            callback="parse_item",
            follow=True,
        ),
    )

    def parse_item(self, response):
        parsed_content = "".join(response.xpath("*//p/text()").getall())
        parsed_content = replace_escape_chars(parsed_content)
        title = response.xpath("//title/text()").get("")
        pdf_links_selectors = response.xpath(
            '//a[contains(@href, ".pdf")]/@href'
        ).extract()
        for pdf_link in pdf_links_selectors:
            yield response.follow(pdf_link, callback=self.parse_pdf)
        yield {
            "url": response.url,
            "content": parsed_content,
            "title": title,
            "metadata": extruct.extract(
                response.text, response.url, syntaxes=["opengraph", "json-ld"]
            ),
            "filetype": "html",
        }

    def parse_pdf(self, response):
        reader = PyPDF2.PdfReader(io.BytesIO(response.body))
        content = ""
        for page in reader.pages:
            content += page.extract_text()
        title = reader.metadata.title if reader.metadata.title else ""
        yield {
            "url": response.url,
            "title": title,
            "content": content,
            "filetype": "pdf",
        }


class CrawlerManager:
    def __init__(self):
        self.url = ""
        self.queue = multiprocessing.Queue(1)

    def _start_crawler_process(self, url, queue):
        runner = CrawlerRunner(
            settings={"ITEM_PIPELINES": {"api.pipelines.StoreItem": 100}}
        )
        scrapy.utils.log.configure_logging(
            {
                "LOG_FORMAT": "%(levelname)s: %(message)s",
            },
        )
        count = 0

        def track_pages():
            nonlocal count
            count += 1
            while not queue.empty():
                queue.get()
            queue.put(count)

        crawler = runner.create_crawler(PageCrawler)
        crawler.signals.connect(track_pages, signals.item_scraped)
        crawler_def = crawler.crawl(start_url=url)
        crawler_def.addBoth(lambda _: reactor.stop())
        reactor.run()

    def start_crawler(self, url="none"):
        self.url = url
        self.crawler_process = multiprocessing.Process(
            target=self._start_crawler_process, args=(url, self.queue)
        )
        self.crawler_process.start()

    def is_crawling(self):
        if self.crawler_process.is_alive():
            return "running"
        else:
            return "stopped"

    def get_pages(self):
        if self.is_crawling():
            return self.queue.get()
        else:
            return self.saved_pages

    def stop_crawler(self):
        self.saved_pages = self.queue.get_nowait()
        self.crawler_process.terminate()
