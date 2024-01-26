import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/Test.dart';
import '../TestScreen.dart';
import '../MenuScreen.dart';
import '../services/timer.dart';

class ListeningScreen extends StatefulWidget {
  final Test test;
  ListeningScreen(this.test, {Key? key}) : super(key: key);

  @override
  State<ListeningScreen> createState() => _ListeningScreenState(test);
}

class _ListeningScreenState extends State<ListeningScreen> {
  final Test test;
  _ListeningScreenState(this.test, {Key? key});

  TimerController _timerController = TimerController();
  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  late Map<String, dynamic> listening = {"task":"error"};
  late Map<String, dynamic> listeningQuestion = {"task":"error"};

  @override
  Widget build(BuildContext context) {
    final CollectionReference listeningCollection = FirebaseFirestore.instance
        .collection('compilations')
        .doc("TUhwJDuJ556MTp9zc3CH")
        .collection("tests")
        .doc(test.docId)
        .collection("listening");

    listeningCollection.get().then(
          (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          listening = docSnapshot.data() as Map<String, dynamic>;
          listening["id"] = docSnapshot.id;
        }
        final CollectionReference listeningQuestionCollection = FirebaseFirestore.instance
            .collection('compilations')
            .doc("TUhwJDuJ556MTp9zc3CH")
            .collection("tests")
            .doc(test.docId)
            .collection("listening")
            .doc(listening["id"])
            .collection("question");

        listeningQuestionCollection.get().then(
              (querySnapshot) {
            for (var docSnapshot in querySnapshot.docs) {
              listeningQuestion = docSnapshot.data() as Map<String, dynamic>;
              listeningQuestion["id"] = docSnapshot.id;
            }
          },
          onError: (e) => print("Error completing: $e"),
        );
      },
      onError: (e) => print("Error completing: $e"),
    );

    Widget _listening() {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final minutes = twoDigits(_timerController.duration.inMinutes.remainder(60));
      final seconds = twoDigits(_timerController.duration.inSeconds.remainder(60));

      TextEditingController answerController = TextEditingController();

      return Container(
        padding: EdgeInsets.only(top: 15),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Column(
              children: [
                Text("LISTENING", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
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
                SizedBox(height: 10),
                Container(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade200, foregroundColor: Colors.black
                    ),
                    child: Text("Play audio", style: TextStyle(fontSize: 20)),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  width: 300,
                  child: LinearProgressIndicator(
                    value: 0.1,
                    minHeight: 3,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent.shade200),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 350,
                  child: Column(
                    children: [
                      Text(listening["task"], style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
                      Text(listeningQuestion["text"])
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 350,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: TextField(
                    controller: answerController,
                    style: TextStyle(color: Colors.white),
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Your comma-separated answers',
                      labelStyle: TextStyle(color: Colors.black12),
                      border: InputBorder.none,
                    ),
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
            _listening(),
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