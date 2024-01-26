import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RPage extends StatefulWidget {
  RPage({Key? key}) : super(key: key);

  @override
  State<RPage> createState() => ReadingScreen();
}

///Changing class to State<QPage> to have ability to use setState function
class ReadingScreen extends State<RPage> {
  ReadingScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reading'),
          backgroundColor: Colors.teal,
          elevation: 4,
        ),
        body: Column(
          children: [
            Text("title"),
            Text("text"),
            Text("questions")
          ],
        ));
  }
}
