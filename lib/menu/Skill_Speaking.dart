import 'package:flutter/material.dart';
import '../services/Test.dart';
import '../TestScreen.dart';
import '../MenuScreen.dart';
import '../services/timer.dart';

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
                      Text("Bla bla bla", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
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