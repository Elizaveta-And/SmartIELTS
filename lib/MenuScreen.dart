import 'package:flutter/material.dart';
//
import 'package:url_launcher/url_launcher.dart' as launcher;
//
class Menu extends StatelessWidget {
  final List<String> buttonLabels = [
    "About IELTS",
    "Speaking: Question types",
    "Listening: Question types",
    "Reading: Question types",
    "Writing: Question types",
  ];
//
  final List<String> externalLinks = [
    'https://ielts.org/about-ielts',
    'https://ieltsliz.com/ielts-speaking-part-1-topics/',
    'https://ieltsliz.com/ielts-listening/',
    'https://ieltsliz.com/ielts-reading-question-types/',
    'https://ieltsliz.com/types-of-ielts-essays/',
  ];
//
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(top: 80, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 1, height: 1,),
                  Text(
                    "MENU",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 35,
                      color: Colors.deepPurple,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: buttonLabels.length,
                  itemBuilder: (context, index) {
                    return TextButton(
                      onPressed: () {
                        _launchURL(externalLinks[index]);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_right, size: 40, color: Colors.purple,),
                          Text(buttonLabels[index], style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
//
  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        launcher.launchUrl(Uri.parse('https://flutter.dev'));
      },
      child: Text('Open Link'),
    );
  }
  void _launchURL(String url) async {
    launcher.launchUrl(Uri.parse(url));
  }
  //
}