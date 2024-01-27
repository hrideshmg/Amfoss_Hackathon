

import 'package:flutter/material.dart';
import 'package:search/resultview.dart';
import 'package:google_fonts/google_fonts.dart';
/*import 'package:search/viewTab.dart';*/




class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final search = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
      children:[
      Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        top: screenHeight*0.58,
        left: screenWidth*0.1,
        child: Container(
          width: screenWidth*0.8,
          height: screenHeight*0.06,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40))),
          
          child: Material(
            elevation: 20,
            child: TextField (
              controller: search,
              decoration: const InputDecoration(
                          hintText: 'search',
                          hintStyle: TextStyle(fontSize: 11),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          
                        ),
              onSubmitted: (value) {
                Navigator.push(
                
                            context,
                            MaterialPageRoute(builder: (context) => resultview(
                              searched: search.text
                            )),
                          );
              },

            ) ))),
      Positioned(
        right: 10,
        bottom: 10,
        child: (
          TextButton(
            onPressed: (){},
            style: TextButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
            child: const Text('+',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
                  
          )
        )
      ),
      Positioned(
        left: 15,
        bottom: 23,
        child: Container(
          
          child: IconButton(
            icon: Icon(Icons.dynamic_feed_outlined,size: 30,),
            onPressed: () {
              /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => viewTab()),
                        );*/
            },
          ))),
      Positioned(
        left: screenWidth*0.34,
        top: screenHeight*0.35,
        child: Text('what are you',
        style: TextStyle(
          fontFamily: GoogleFonts.anton().fontFamily,
          fontSize: 28,
        ),)),
      Positioned(
        left: screenWidth*0.25,
        top: screenHeight*0.40,
        child: Text('CURIOUS',
        style: TextStyle(
          fontFamily: GoogleFonts.permanentMarker().fontFamily,
          fontSize: 48,
        ),)),
      Positioned(
        left: screenWidth*0.44,
        top: screenHeight*0.485,
        child: Text('about',
        style: TextStyle(
          fontFamily: GoogleFonts.anton().fontFamily,
          fontSize: 28,
        ),)),
      ]
    )

    );

  }
}