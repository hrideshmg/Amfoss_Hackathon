from itemadapter import ItemAdapter
from pymongo import TEXT

from utils import get_db


class StoreItem:
    def open_spider(self, spider):
        self.client, self.database = get_db("crawl_test")
        self.collection = self.database.webpages
        self.collection.create_index(
            {"content": TEXT, "title": TEXT}, default_language="english"
        )

    def process_item(self, item, spider):
        adapter = ItemAdapter(item)

        url = adapter.get("url")
        content = adapter.get("content")
        if adapter.get("metadata")["opengraph"]:
            title = [
                x[1]
                for x in adapter.get("metadata")["opengraph"][0]["properties"]
                if x[0] == "og:title"
            ][0]
        else:
            title = adapter.get("title")
        self.collection.insert_one({"url": url, "content": content, "title": title})

    def close_spider(self, spider):
        self.client.close()
