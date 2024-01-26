import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Test.dart';
import 'TestScreen.dart';
import 'MenuScreen.dart';
import 'timer.dart';

class SpeakingScreen extends StatefulWidget {
  final Test test;
  SpeakingScreen(this.test, {Key? key}) : super(key: key);

  @override
  State<SpeakingScreen> createState() => _SpeakingScreenState(test);
}

class _SpeakingScreenState extends State<SpeakingScreen> {
  final Test test;
  _SpeakingScreenState(this.test, {Key? key});
  TimerController _timerController = TimerController();

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    getSpeaking() async {
      final CollectionReference speakingCollection = FirebaseFirestore.instance.collection("compilations")
          .doc("TUhwJDuJ556MTp9zc3CH")
          .collection("tests")
          .doc(test.docId)
          .collection("speaking");

      late List<Map<String, dynamic>> speaking = [
        {"question": "error"},{"question":"error"}
      ];

      await speakingCollection.get().then(
            (querySnapshot) {
          speaking = querySnapshot.docs.map((DocumentSnapshot docSnapshot) {
            return docSnapshot.data() as Map<String, dynamic>;
          }).toList();
        },
        onError: (e) {
          print("Error completing: $e");
        },
      );
      return Future.value(speaking);
    }

    Widget _speaking() {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final minutes = twoDigits(_timerController.duration.inMinutes.remainder(60));
      final seconds = twoDigits(_timerController.duration.inSeconds.remainder(60));

      return Container(
        padding: EdgeInsets.only(top: 15),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Column(
              children: [
                Text("SPEAKING", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                SizedBox(height: 20),
                Container(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                      _timerController.toggleTimer(_update);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent.shade100,
                      foregroundColor: Colors.black,
                    ),
                    child: Text(
                      _timerController.timerState == TimerState.running
                          ? "PAUSE        Time: $minutes:$seconds"
                          : _timerController.timerState == TimerState.paused
                          ? "RESUME       Time: $minutes:$seconds"
                          : "START!        Time: $minutes:$seconds",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 350,
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: getSpeaking(),
                        builder: (context, snapshot) {
                          if(snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          if(snapshot.connectionState == ConnectionState.waiting) {
                            print("shown it");
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            );
                          }

                          return Column(
                            children: [
                              Container(
                                width: 350,
                                height: 400,
                                child: ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(snapshot.data![index]["question"]),
                                          ),
                                        ],
                                      );
                                    },
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                )
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
            _speaking(),
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
              onPressed: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}