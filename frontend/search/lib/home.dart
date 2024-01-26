import 'dart:convert';
import 'package:search/globals.dart' as globals;
import 'dart:async';
import 'package:search/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Uri> websiteUris = [];
  String status = "";
  int numberOfPages = 0;
  TextEditingController urlController = TextEditingController();
  String currenturl = '';
  String currentstatus = 'idle';
  String pages = "0";
  bool stopped = false;

  starttimer() {
    const onesec = Duration(milliseconds: 1500);
    Timer.periodic(onesec, getstatus);
  }

  startcrawler(url) async {
    setState(() {
      pages = "0";
    });
    var client = http.Client();

    var uri = Uri.parse('${globals.ip}/start_crawl');
    client.post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{'url': url}));
    starttimer();
    stopped = false;
  }

  stopcrawler() async {
    var client = http.Client();
    stopped = true;
    var uri = Uri.parse('${globals.ip}/stop_crawl');
    client.post(
      uri,
    );
  }

  getstatus(Timer t) async {
    var client = http.Client();

    if (stopped) {
      t.cancel();
    }

    var uri = Uri.parse('${globals.ip}/crawler_status');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var status_str = response.body;
      var status = jsonDecode(status_str) as Map<String, dynamic>;
      //Data status=dataFromJson(json)[0];
      if (status['status'] == "stopped") {
        t.cancel();
        stopped = true;
        status['status'] = "completed";
      }
      if (stopped) {
        status['status'] = "stopped";
      }
      setState(() {
        currenturl = status['url'] ?? '';
        currentstatus = status['status'] ?? '';
        pages = status['pages'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'App Name',
              style: TextStyle(fontSize: 60),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(255, 236, 234, 234).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: urlController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Type in a URL....',
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.8)),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (value) {
                            startcrawler(urlController.text);
                            urlController.clear();
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          startcrawler(urlController.text);
                          urlController.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.black.withOpacity(0.5),
            //   ),
            //   child: Text(
            //     "URL: $currenturl",
            //     style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //   ),
            // ),

            // ElevatedButton(
            //   onPressed: () {
            //     setState(() {
            //     });
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.black.withOpacity(0.5),
            //   ),
            //   child: Text(
            //     "Status: $currentstatus",
            //     style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //   ),
            // ),
            Stack(children: [
              Container(
                // color: Color.fromARGB(255, 255, 255, 255),
                width: screenWidth * 0.38,
                height: screenHeight * 0.05,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                    Positioned(
                      child: TextButton(
                        onPressed: () {
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color.fromARGB(255, 253, 253, 253).withOpacity(1),
                        ),
                        child: Text(
                          "Pages: $pages",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        stopcrawler();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.5),
                      ),
                      child: Text(
                        'stop',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ]),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black.withOpacity(0.5),
              ),
              child: Text(
                'search',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     getstatus;
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.black.withOpacity(0.5),
            //   ),
            //   child: Text(
            //     "status",
            //     style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void addUrl(Uri uri) {
    setState(() {
      websiteUris.add(uri);
    });
  }
}
