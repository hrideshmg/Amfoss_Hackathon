// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Data> dataFromJson(String str) => List<Data>.from(json.decode(str).map((x) => Data.fromJson(x)));

String dataToJson(List<Data> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Data {
    String url;
    String content;
    String title;

    Data({
        required this.url,
        required this.content,
        required this.title,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        url: json["url"],
        content: json["content"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "content": content,
        "title": title,
    };
}

