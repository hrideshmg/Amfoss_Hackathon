from pymongo import MongoClient


def get_db(db_name="none", username="hridesh699", password="system"):
    client = MongoClient(
        "mongodb+srv://testing.s87snto.mongodb.net/",
        username=username,
        password=password,
    )
    db_handle = client[db_name]
    return client, db_handle
