import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/Test.dart';
import '../TestScreen.dart';
import '../MenuScreen.dart';

class VocabularyScreen extends StatefulWidget {
  final Test test;
  VocabularyScreen(this.test, {Key? key}) : super(key: key);

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState(test);
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  final Test test;
  _VocabularyScreenState(this.test, {Key? key});

  List<Map<String, dynamic>> vocabulary = [{"word":"error"}];
  @override
  Widget build(BuildContext context) {
    final CollectionReference vocabularyCollection = FirebaseFirestore.instance
        .collection('vocabulary');

    vocabularyCollection.get().then(
          (querySnapshot) {
        vocabulary = querySnapshot.docs.map((DocumentSnapshot docSnapshot) {
          return docSnapshot.data() as Map<String, dynamic>;
        }).toList();
      },
      onError: (e) => print("Error completing: $e"),
    );

    Widget _Vocabulary() {

      return Container(
        padding: EdgeInsets.only(top: 15),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Column(
              children: [
                Text("VOCABULARY",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                SizedBox(height: 20),
                Container(
                  width: 350,
                  height: 600,
                  child: ListView.builder(
                    itemCount: vocabulary.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text("${vocabulary[index]["word"]} - ${vocabulary[index]["translation"]}", style: TextStyle(fontSize: 20)),
                          ),
                        ],
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

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        backgroundColor: Colors.purple.shade200,
        titleSpacing: 40,
        title: Text("TEST №_",
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
              icon:
              Icon(Icons.exit_to_app, size: 38, color: Colors.deepPurple),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TestScreen(test)),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
            _Vocabulary(),
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