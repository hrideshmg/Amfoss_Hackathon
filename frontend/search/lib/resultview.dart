import 'package:flutter/material.dart';
import 'package:search/globals.dart' as globals;
import 'package:search/resultlist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:search/models/data.dart';
import 'package:search/services/remote_service.dart';

class resultview extends StatefulWidget {
  final String searched;

  resultview({required this.searched});

  @override
  State<resultview> createState() => _ResultState();
}

class _ResultState extends State<resultview> {
  late TextEditingController search;
  final List result = [
    ['a', 'b', 'c'],
    ['d', 'e', 'f'],
    ['g', 'e', 'h'],
  ];
  List<Data>? data;
  var isLoaded = false;
  String format = 'html';

  @override
  void initState() {
    super.initState();
    search = TextEditingController(text: widget.searched);

    getData();
  }

  /*
  Future<void> sendPostRequest() async {
     var response = await http.post(apiUrl as Uri,
         headers: {"Content-Type": "application/json"},
         body: jsonEncode({
           "keyword": search.text,
           "filter": 'PDF',
          
         }));

     if (response.statusCode == 200) {
       print('success');
     } else {
       print('error');
     }
   }
*/
  getData() async {
    data = await RemoteService().getData(search.text, format);
    if (data != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Material(
                elevation: 7,
                child: SizedBox(
                    height: screenHeight * 0.13,
                    width: screenWidth,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: TextField(
                        controller: search,
                        decoration: const InputDecoration(
                          hintText: 'search',
                          hintStyle: TextStyle(fontSize: 11),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        onSubmitted: (value) {
                          getData();
                        },
                      ),
                    ))),
            Container(
                height: screenHeight * 0.87,
                width: screenWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return (Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                              height: 110,
                              width: screenWidth * 0.9,
                              child: resultlist(
                                  url: data![index].url,
                                  title: data![index].title,
                                  body: data![index].content)),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ));
                    }))
          ],
        ));
  }
}
