from django.urls import path

from api import views

urlpatterns = [
    path("", views.ApiRoot.as_view()),
    path("start_crawl", views.StartCrawl.as_view(), name="start-crawl"),
    path("stop_crawl", views.StopCrawl.as_view(), name="stop-crawl"),
    path("get_pages", views.GetPages.as_view(), name="get-pages"),
    path("search/<str:filter>/<str:keywords>", views.Search.as_view(), name="search"),
]
