import 'dart:convert';
import 'package:search/globals.dart' as globals;

import 'package:search/models/data.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Data>?> getData(search, format) async {
    var client = http.Client();

    var uri = Uri.parse('${globals.ip}/search');
    var response = await client.post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body:
            jsonEncode(<String, String>{'keywords': search, 'filter': format}));
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);

      return dataFromJson(json);
    } else {
      print("===================================================");
      print(response.body);
      print("===================================================");
    }
  }
}

