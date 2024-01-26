from rest_framework import status
from rest_framework.response import Response

from api.crawler import CrawlerManager
from api.custom_views import MApiView
from api.serializers import SearchSerializer, UrlSerializer
from utils import get_db

crawler_manager = CrawlerManager()


class StartCrawl(MApiView):
    def post(self, request):
        serializer = UrlSerializer(data=request.data)
        if serializer.is_valid():
            crawler_manager.start_crawler(serializer.data.get("url"))
            return Response({"Started Crawler"}, status.HTTP_200_OK)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class StopCrawl(MApiView):
    def post(self, request):
        if crawler_manager.is_crawling():
            crawler_manager.stop_crawler()
            return Response({"Crawler Stopped"}, status=status.HTTP_200_OK)
        else:
            return Response(
                {"Crawler is not running"}, status=status.HTTP_400_BAD_REQUEST
            )


class CrawlerStatus(MApiView):
    def get(self, request):
        if crawler_manager.url:  # If crawler has ran once
            return Response(
                {
                    "url": crawler_manager.url,
                    "running": crawler_manager.is_crawling(),
                    "pages": crawler_manager.get_pages(),
                },
                status=status.HTTP_200_OK,
            )
        else:
            return Response(
                "Crawler has not run yet", status=status.HTTP_400_BAD_REQUEST
            )


class Search(MApiView):
    def post(self, request):
        serializer = SearchSerializer(data=request.data)
        database = get_db("mock_data")[1]
        collection = database.webpages
        if serializer.is_valid():
            keywords = serializer.data.get("keywords")
            results = list(
                collection.find({"$text": {"$search": keywords}}, {"_id": False})
            )
            if results:
                return Response(results, status=status.HTTP_200_OK)
            else:
                return Response("No results found", status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
