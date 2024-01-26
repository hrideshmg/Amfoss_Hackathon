// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Data> dataFromJson(String str) => List<Data>.from(json.decode(str).map((x) => Data.fromJson(x)));

String dataToJson(List<Data> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Data {
    String url;
    String status;
    String pages;

    Data({
        required this.url,
        required this.status,
        required this.pages,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        url: json["url"],
        status: json["status"],
        pages: json["pages"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "status": status,
        "pages": pages,
    };
}

