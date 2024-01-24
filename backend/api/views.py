from rest_framework import status
from rest_framework.response import Response

from api.custom_views import MApiView
from utils import get_db


class ApiRoot(MApiView):
    def get(self, request):
        collection = self.database["spiderdb"]
        return Response({collection.find_one().get("content")}, status.HTTP_200_OK)


class Crawl(MApiView):
    def get(self, request, url):
        pass
        return Response(status.HTTP_200_OK)


class Search(MApiView):
    def get(self, request, filter, keywords):
        pass
        return Response({filter, keywords}, status.HTTP_200_OK)
