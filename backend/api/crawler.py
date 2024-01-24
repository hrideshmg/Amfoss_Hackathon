from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule
from w3lib.url import url_query_cleaner
from w3lib.html import replace_escape_chars
import extruct


def process_links(links):
    for link in links:
        link.url = url_query_cleaner(link.url)
        yield link

class ImdbCrawler(CrawlSpider):
    name = 'imdb'
    allowed_domains = ['en.wikipedia.org']
    start_urls = ['https://en.wikipedia.org/wiki/Web_crawler']
    rules = (
        Rule(
            LinkExtractor(
            ),
            process_links=process_links,
            callback='parse_item',
            follow=True
        ),
    )

    def parse_item(self, response):
        parsed_content = ''.join(response.xpath('*//p/text()').getall())[:1200]
        parsed_content = replace_escape_chars(parsed_content)
        parsed_content
        return {
            'url': response.url,
            'content': parsed_content,
            'metadata': extruct.extract(
                response.text,
                response.url,
                syntaxes=['opengraph', 'json-ld']
            ),
        }