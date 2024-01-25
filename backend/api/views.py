from rest_framework import status
from rest_framework.response import Response
from rest_framework.reverse import reverse

from api.crawler import CrawlerManager
from api.custom_views import MApiView
from api.serializers import UrlSerializer

crawler_manager = CrawlerManager()


class ApiRoot(MApiView):
    def get(self, request):
        return Response(
            {
                "start crawl": reverse("start-crawl", request=request),
                "stop crawl": reverse("stop-crawl", request=request),
                "search": reverse(
                    "search",
                    request=request,
                    kwargs={"filter": "filter", "keywords": "keywords"},
                ),
                "get pages": reverse("get-pages", request=request),
            },
            status=status.HTTP_200_OK,
        )


class StartCrawl(MApiView):
    def post(self, request):
        serializer = UrlSerializer(data=request.data)
        if serializer.is_valid():
            crawler_manager.start_crawler(serializer.data.get("url"))
            return Response({"Started Crawler"}, status.HTTP_200_OK)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class StopCrawl(MApiView):
    def get(self, request):
        crawler_manager.stop_crawler()
        return Response({crawler_manager.is_crawling()}, status=status.HTTP_200_OK)


class GetPages(MApiView):
    def get(self, request):
        return Response({crawler_manager.get_pages()})


class Search(MApiView):
    def get(self, request, filter, keywords):
        pass
        return Response({filter, keywords}, status=status.HTTP_200_OK)
