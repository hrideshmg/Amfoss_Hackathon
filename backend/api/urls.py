from django.urls import path

from api import views

urlpatterns = [
    path("start_crawl", views.StartCrawl.as_view(), name="start-crawl"),
    path("stop_crawl", views.StopCrawl.as_view(), name="stop-crawl"),
    path("crawler_status", views.CrawlerStatus.as_view(), name="crawler-status"),
    path("search", views.Search.as_view(), name="search"),
]

