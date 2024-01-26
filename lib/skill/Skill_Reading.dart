import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/Test.dart';
import '../TestScreen.dart';
import '../MenuScreen.dart';
import '../services/timer.dart';

class ReadingScreen extends StatefulWidget {
  final Test test;
  ReadingScreen(this.test, {Key? key}) : super(key: key);

  @override
  State<ReadingScreen> createState() => _ReadingScreenState(test);
}

class _ReadingScreenState extends State<ReadingScreen> {
  final Test test;
  _ReadingScreenState(this.test, {Key? key});
  final TimerController _timerController = TimerController();

  bool isExpanded = false;

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  late Map<String, dynamic> text = {"text": "error"};
  late List<Map<String, dynamic>> questions = [
    {"question": "error"},
  ];
  late List<String> userAnswers = ["ans1", "ans2"];
  @override
  Widget build(BuildContext context) {
    /// Получение текста, вопросов и ответов с сервера
    Widget _Reading() {
      final CollectionReference reading = FirebaseFirestore.instance
          .collection('compilations')
          .doc("TUhwJDuJ556MTp9zc3CH")
          .collection("tests")
          .doc(test.docId)
          .collection("reading");

      reading.get().then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            text = docSnapshot.data() as Map<String, dynamic>;
            text["id"] = docSnapshot.id;
          }
        },
        onError: (e) => print("Error completing: $e"),
      );

      final CollectionReference questionsCollection = FirebaseFirestore.instance
          .collection('compilations')
          .doc("TUhwJDuJ556MTp9zc3CH")
          .collection("tests")
          .doc(test.docId)
          .collection("reading")
          .doc(text["id"])
          .collection("questions");

      /// Получить ответы с сервера, сравнить их с ответом пользователя и отправить обратно результат
      /// Неготово
      submitAnswers() {
        print(userAnswers);
      }

      /// Вывод вопросов и полей для ответов
      Widget Questions() {
        questionsCollection.get().then(
          (querySnapshot) {
            questions = querySnapshot.docs.map((DocumentSnapshot docSnapshot) {
              Map<String, dynamic> snapWithId =
                  docSnapshot.data() as Map<String, dynamic>;
              snapWithId["id"] = docSnapshot.id;
              print(snapWithId);
              return snapWithId as Map<String, dynamic>;
            }).toList();
          },
          onError: (e) {
            print("Error completing: $e");
            return Text("Error");
          },
        );
        return Column(
          children: [
            Container(
              height: 300,
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(questions[index]["question"]),
                      ),
                      TextField(
                        onChanged: (value) {
                          userAnswers[index] = value;
                        },
                        maxLines: 2,
                        decoration: const InputDecoration(),
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: submitAnswers(), child: Text("Submit answers"))
          ],
        );
      }

      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final minutes =
          twoDigits(_timerController.duration.inMinutes.remainder(60));
      final seconds =
          twoDigits(_timerController.duration.inSeconds.remainder(60));

      return Container(
        padding: EdgeInsets.only(top: 15),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Column(
              children: [
                Text("READING",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
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
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade200,
                      foregroundColor: Colors.black,
                    ),
                    label: Text("Text",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 20)),
                    icon: Icon(isExpanded
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down),
                  ),
                ),
                if (isExpanded)
                  Container(
                    width: 350,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(text["textname"],
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center),
                        Text(
                          text["text"],
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 10),
                Container(width: 350, height: 400, child: Questions()),
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
        title: Text("TEST №${test.number}",
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
              icon: Icon(Icons.exit_to_app, size: 38, color: Colors.deepPurple),
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
        _Reading(),
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
