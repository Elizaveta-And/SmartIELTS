import 'package:cloud_firestore/cloud_firestore.dart';

class Test {
  late String name;
  late int number;
  late String docId;

  Test.fromDoc(QueryDocumentSnapshot doc){
    name = doc["name"];
    docId = doc.id;
    number = doc["number"];
  }

  Test.fromDocument(DocumentSnapshot doc){
    name = doc["name"];
    docId = doc.id;
    number = doc["number"];
  }
}