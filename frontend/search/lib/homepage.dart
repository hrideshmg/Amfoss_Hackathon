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
  var format = "html";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
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
            top: screenHeight * 0.037,
            left: screenWidth * 0.155,
            child: Container(
              height: screenHeight*0.5,
              width: screenWidth*0.7,
              decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/icon.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            )
          ),
          Positioned(
              top: screenHeight * 0.44,
              left: screenWidth * 0.07,
              child: Row(
                children: [
                  Container(
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.07,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: Material(
                        elevation: 20,
                        child: TextField(
                          controller: search,
                          decoration: const InputDecoration(
                            hintText: 'search',
                            hintStyle: TextStyle(fontSize: 11),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                            ),
                          ),
                          onSubmitted: (value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => resultview(
                                      searched: search.text, filter: format)),
                            );
                          },
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Material(
                      elevation: 20,
                      child: DropdownMenu(
                          width: 100,
                          
                          label: const Text("filter"),
                          initialSelection: "html",
                          onSelected: (filter) {
                            format = filter!;
                          },
                          dropdownMenuEntries:
                              ["html", "pdf"].map((String filter) {
                            return DropdownMenuEntry(
                                value: filter, label: filter);
                          }).toList()),
                    ),
                  )
                ],
              )),
          Positioned(
              right: 10,
              bottom: 10,
              child: (TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 0, 0, 0),
                ),
                child: const Text(
                  '',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ))),
          

          Positioned(
              left: screenWidth * 0.20,
              top: screenHeight * 0.60,
              child: Text(
                'what are you',
                style: TextStyle(
                  fontFamily: GoogleFonts.lilitaOne().fontFamily,
                  fontSize: 44,
                ),
              )),
          Positioned(
              left: screenWidth * 0.145,
              top: screenHeight * 0.68,
              child: Text(
                'CURIOUS',
                style: TextStyle(
                  fontFamily: GoogleFonts.permanentMarker().fontFamily,
                  fontSize: 66,
                ),
              )),
          Positioned(
              left: screenWidth * 0.33,
              top: screenHeight * 0.81,
              child: Text(
                'about?',
                style: TextStyle(
                  fontFamily: GoogleFonts.lilitaOne().fontFamily,
                  fontSize: 44,
                ),
              )),
        ]));
  }
}

