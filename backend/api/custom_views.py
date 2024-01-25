from rest_framework.views import APIView

from utils import get_db


class MApiView(APIView):
    def __init__(self):
        super().__init__()
        self.database = get_db()
