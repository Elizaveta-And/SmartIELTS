import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late String _loginU;
  late String _passwordU;
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    Widget _login() {
      return Padding(
          padding: EdgeInsets.only(top: 100),
          child: Container(
              child: Align(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(70), topLeft: Radius.circular(70)),
                  color: Colors.white,
                  border: Border.all(color: Colors.purple.shade300, width: 13)),
              child: Column(
                children: [
                  Text(
                    "SMART",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 60, letterSpacing: 6),
                    textAlign: TextAlign.center,
                  ),
                  Text("IELTS",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35, letterSpacing: 3),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )));
    }

    Widget _input(Icon icon, String string, TextEditingController controller,
        bool obscure) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(40), topLeft: Radius.circular(40)),
          color: Colors.purple.shade300,
        ),margin: EdgeInsets.symmetric(horizontal: 20),

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(60), topLeft: Radius.circular(60)),
            color: Colors.white,
          ),
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 20, color: Colors.black26),
                hintText: string,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    borderSide: BorderSide(width: 3, color: Colors.purple.shade200)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(60),
                      topLeft: Radius.circular(60),
                    ),
                    borderSide: BorderSide(width: 1.5, color: Colors.purple.shade300)
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.deepPurple),
                    child: icon,
                  ),
                )),
          ),
        ),
      );
    }

    Widget button(String text, void function()) {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IeltsSmart()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple.shade300,
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
    }

    Widget _form(String label, void function()) {
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 20, top: 40),
                child: _input(
                    Icon(Icons.login, size: 40,), "123@gmail.com", _loginController, false)),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: _input(Icon(Icons.key, size: 40,), "********",
                    _passwordController, true)),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: button(label, function)))
          ],
        ),
      );
    }

    void _loginButtonUser() async {
      _loginU = _loginController.text;
      _passwordU = _passwordController.text;

      if (_loginU.isEmpty || _passwordU.isEmpty) return;

      _loginController.clear();
      _passwordController.clear();
    }

    void _registerButtonUser() async {
      _loginU = _loginController.text;
      _passwordU = _passwordController.text;

      if (_loginU.isEmpty || _passwordU.isEmpty) return;

      _loginController.clear();
      _passwordController.clear();
    }

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            _login(),
            SizedBox(
              height: 20,
            ),
            (showLogin
                ? Column(
                    children: <Widget>[
                      _form("Log in", _loginButtonUser),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                            child: Text("Not logged in? Sign up!",
                                style: TextStyle(fontSize: 20)),
                            onTap: () {
                              setState(() {
                                showLogin = false;
                              });
                            }),
                      )
                    ],
                  )
                : Column(
                    children: <Widget>[
                      _form("Sign up", _registerButtonUser),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                            child: Text("Signed up? Log in!",
                                style: TextStyle(fontSize: 20)),
                            onTap: () {
                              setState(() {
                                showLogin = true;
                              });
                            }),
                      )
                    ],
                  ))
          ]),
        ));
  }
}
