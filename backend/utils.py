from pymongo import MongoClient


def get_db(db_name="none", username="hridesh699", password="system"):
    client = MongoClient(
        host="localhost",
        port=27017,
    )
    db_handle = client[db_name]
    return client, db_handle
