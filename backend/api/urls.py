from django.urls import path

from api import views

urlpatterns = [
    path("crawl/<str:url>", views.ApiRoot.as_view()),
    path("search/<str:filter>/<str:keywords>", views.Search.as_view()),
    path("", views.ApiRoot.as_view()),
    path("mock_search", views.MockSearch.as_view()),
]
