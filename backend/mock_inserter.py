import json

import pymongo

client = pymongo.MongoClient(
    "mongodb+srv://testing.s87snto.mongodb.net/",
    username="hridesh699",
    password="system",
)
database = client.mock_data
collection = database.webpages
with open("mock_data.json") as file:
    data = json.loads(file.read())
    selection = [0, 14, 13, 12, 16, 29, 30, 31, 34, 37]
    for index, website in enumerate(data):
        if index in selection:
            url = website["url"]
            content = website["content"]
            title = [
                x[1]
                for x in website["metadata"]["opengraph"][0]["properties"]
                if x[0] == "og:title"
            ][0]
            collection.insert_one({"url": url, "content": content, "title": title})
