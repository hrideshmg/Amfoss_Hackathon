import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class resultlist extends StatelessWidget {
  resultlist({required this.url, required this.title, required this.body});

  final String url;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final websiteUri = Uri.parse(url);
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          launchUrl(
            websiteUri,
            mode: LaunchMode.inAppWebView,
          );
        },
        child: Material(
          elevation: 5,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            height: 150,
            width: screenWidth * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontFamily: GoogleFonts.ibmPlexMono().fontFamily,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                  child: Text(
                    url,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontFamily: GoogleFonts.ibmPlexMono().fontFamily,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      body.trim(),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontFamily: GoogleFonts.josefinSans().fontFamily,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void launchUrl(Uri uri, {LaunchMode? mode}) async {
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString(),
          forceSafariVC: true,
          forceWebView: true,
          enableJavaScript: true,
          webOnlyWindowName: "_blank");
    } else {
      throw 'Could not launch $uri';
    }
  }
}
