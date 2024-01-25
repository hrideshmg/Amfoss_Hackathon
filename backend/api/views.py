import json

from bson import ObjectId
from rest_framework import status
from rest_framework.response import Response

from api.custom_views import MApiView


class JSONEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, ObjectId):
            return str(o)
        return json.JSONEncoder.default(self, o)


class ApiRoot(MApiView):
    def get(self, request):
        collection = self.database["webpages"]
        return Response(["hi", "bye"], status.HTTP_200_OK)


class Crawl(MApiView):
    def get(self, request, url):
        pass
        return Response(status.HTTP_200_OK)


class Search(MApiView):
    def get(self, request, filter, keywords):
        pass
        return Response({filter, keywords}, status.HTTP_200_OK)


class MockSearch(MApiView):
    def get(self, request):
        webpages = self.database["webpages"]
        result = []

        # for page in webpages.find():
        #     result.append(dict(page))
        # print(type(result))
        resp = list(webpages.find({}, {"_id": False}))
        return Response(resp)
