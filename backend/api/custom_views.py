from rest_framework.views import APIView
from utils import get_db

from api.crawler import CrawlerManager


class MApiView(APIView):
    def __init__(self):
        super().__init__()
        self.database = get_db()
