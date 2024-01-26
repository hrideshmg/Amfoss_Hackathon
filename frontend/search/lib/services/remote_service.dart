import 'dart:convert';
import 'dart:math';

import 'package:search/models/data.dart';
import 'package:http/http.dart' as http;

class RemoteService
{
  Future<List<Data>?> getData(search,format) async
  {
    var client = http.Client();

    var uri = Uri.parse('http://192.168.188.204:8000/search');
    var response = await client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String> {'keywords':search, 'filter':'none'})
      );
    if (response.statusCode == 200)
    {
      var json = response.body;
      print(json);

      return dataFromJson(json);
      
    }
    else {
      print("===================================================");
      print(response.body);
      print("===================================================");

    }
  }
}