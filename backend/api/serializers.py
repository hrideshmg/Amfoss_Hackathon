from rest_framework import serializers


class UrlSerializer(serializers.Serializer):
    url = serializers.CharField()
