import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'services/Test.dart';
import 'HomeScreen.dart';
import 'skill/Skill_Speaking.dart';

import 'skill/Skill_Listening.dart';
import 'MenuScreen.dart';
import 'skill/Skill_Reading.dart';
import 'skill/Skill_Vocabulary.dart';
import 'skill/Skill_Writing.dart';

//
import 'dart:async';
//

class TestScreen extends StatefulWidget {
  final Test test;
  const TestScreen(this.test, {Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState(test);
}

class _TestScreenState extends State<TestScreen> {
  final Test test;
  _TestScreenState(this.test, {Key? key});
  @override
  Widget build(BuildContext context) {
    Widget _testInfo() {
      return Container(
        padding: EdgeInsets.only(top: 30),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 350,
            height: 130,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(70), topLeft: Radius.circular(70)),
              color: Colors.greenAccent.shade100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Last score:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Time:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _skills() {
      return Container(
          alignment: Alignment.center,
          width: 400,
          height: 250,
          padding: EdgeInsets.only(left: 21, right: 13),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            childAspectRatio: 1.5,
            children: [
              Container(
                width: 165,
                height: 100,
                margin: EdgeInsets.only(right: 10, bottom: 10),
                decoration: BoxDecoration(color: Colors.purple.shade200),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SpeakingScreen(test)),
                      );},
                    child: Text(
                      "Speaking",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder())),
              ),
              Container(
                width: 165,
                height: 100,
                margin: EdgeInsets.only(right: 10, bottom: 10),
                decoration: BoxDecoration(color: Colors.purple.shade200),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListeningScreen(test)),
                      );},
                    child: Text(
                      "Listening",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder())),
              ),
              Container(
                width: 165,
                height: 100,
                margin: EdgeInsets.only(right: 10, bottom: 10),
                decoration: BoxDecoration(color: Colors.purple.shade200),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReadingScreen(test)),
                      );},
                    child: Text(
                      "Reading",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder())),
              ),
              Container(
                width: 165,
                height: 100,
                margin: EdgeInsets.only(right: 10, bottom: 10),
                decoration: BoxDecoration(color: Colors.purple.shade200),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WritingScreen(test)),
                      );},
                    child: Text(
                      "Writing",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder())),
              ),
            ],
          ));
    }

    Widget _tips() {
      return Container(
          child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 350,
          height: 90,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(70),
                bottomLeft: Radius.circular(70)),
            color: Colors.greenAccent.shade100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VocabularyScreen(test)),
                  );},
                child: Text(
                  "Useful vocabulary",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,

                ),
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder())
              ),
            ],
          ),
        ),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        backgroundColor: Colors.purple.shade200,
        titleSpacing: 40,
        title: Text("SMART IELTS",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        leading: IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Menu(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(-1.0, 0.0);
                        const end = Offset(0.0, 0.0);
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                            position: offsetAnimation, child: child);
                      }));
            }),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10, left: 0),
            child: IconButton(
              icon: Icon(Icons.door_back_door_outlined,
                  size: 38, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IeltsSmart()),
                );
              },
          ),)
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        _testInfo(),
        SizedBox(
          height: 20,
        ),
        _skills(),
        _tips()
      ])),
      bottomNavigationBar: BottomAppBar(
        color: Colors.purple.shade200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(
                Icons.account_balance,
                color: Colors.white,
                size: 45,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
