import 'package:flutter/material.dart';
import 'package:ielts_smart/TestScreen.dart';
import 'package:ielts_smart/MenuScreen.dart';
import 'timer.dart';

class WritingScreen extends StatefulWidget {
  WritingScreen({Key? key}) : super(key: key);

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  TimerController _timerController = TimerController();

  TextEditingController task1Controller = TextEditingController();
  TextEditingController task2Controller = TextEditingController();

  @override

  void dispose() {
    _timerController.dispose();

    task1Controller.dispose();
    task2Controller.dispose();

    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget _Writing() {
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
                Text("WRITING",
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
                  child: Text("Writing task 1",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: 350,
                  child: Text("Firebase writing 1", style: TextStyle(fontSize: 20)),
                ),
                Container(
                width: 360,child: Image.network("https://i0.wp.com/markteacher.com/wp-content/uploads/2022/10/WPTask1DynamicMain1.png?resize=555%2C404&ssl=1")),
                SizedBox(height: 10),
                Container(
                  width: 350,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: TextField(
                    controller: task1Controller,
                    style: TextStyle(color: Colors.black),
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Write your task 1 here',
                      labelStyle: TextStyle(color: Colors.black12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 350,
                  child: Text("Writing task 2",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: 350,
                  child: Text("Firebase writing 2", style: TextStyle(fontSize: 20)),
                ),
                SizedBox(height: 10),
                Container(
                  width: 350,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: TextField(
                    controller: task2Controller,
                    style: TextStyle(color: Colors.black),
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Write your task 2 here',
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
                  MaterialPageRoute(builder: (context) => TestScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
            _Writing(),
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