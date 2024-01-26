import 'package:flutter/material.dart';



class resultlist extends StatelessWidget {

  
  resultlist({required this.url, required this.title, required this.body});

  final String url;
  final String title;
  final String body;
  
  
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body:Material(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          height: 120,
          width: screenWidth*0.9,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: Text(title)
                ),
              Positioned(
                top: 20,
                left: 10,
                child: Text(url)
                ),
              Positioned(
                top: 30,
                left: 10,
                child: Text(body)
                ),
            ],
          ),
        ),
      )
    );
  }
}