from rest_framework import serializers


class UrlSerializer(serializers.Serializer):
    url = serializers.CharField()


class SearchSerializer(serializers.Serializer):
    keywords = serializers.CharField()
    filter = serializers.CharField()
