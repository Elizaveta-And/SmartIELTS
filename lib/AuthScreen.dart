
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course/services/snack_bar.dart';
import 'auth/verify_email_screen.dart';
import 'auth/signup_screen.dart';
import 'auth/reset_password_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool showLogin = true;
  //
  int loginAttempts = 0;
  bool showResetPasswordButton = false;



  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _redirectToVerifyEmail() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VerifyEmailScreen()),
    );
  }

  Future<void> login() async {
    final navigator = Navigator.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginController.text.trim(),
        password: _passwordController.text.trim(),
      );

      print('Login successful');

      navigator.pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      print('Login error: ${e.message}');

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        loginAttempts++;
        if (loginAttempts == 1) {

          setState(() {
            showResetPasswordButton  = true;
          });
        }
        SnackBarService.showSnackBar(
          context,
          'Incorrect email or password. Please try again',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          '${e.code} Unknown error! Try again or contact support.',
          true,
        );
        return;
      }
    }
  }

  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _loginController.text.trim(),
      );

      SnackBarService.showSnackBar(
        context,
        'Password reset email sent. Check your email.',
        false,
      );
    } on FirebaseAuthException catch (e) {
      print('Reset password error: ${e.message}');

      SnackBarService.showSnackBar(
        context,
        'Error sending password reset email. Try again or contact support.',
        true,
      );
    }
  }

  Future<void> register() async {
    String email = _loginController.text.trim();
    String password = _passwordController.text.trim();


    final navigator = Navigator.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (email.isEmpty || password.isEmpty) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _loginController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Clear the text fields
      _loginController.clear();
      _passwordController.clear();

      // Navigate to the verification screen
      //Navigator.pushReplacement(
      //  context,
      //  MaterialPageRoute(builder: (context) => VerifyEmailScreen()),
      //);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarService.showSnackBar(
            context,
            'The password provided is too weak.',
          true,
        );
        return;
      } else if (e.code == 'email-already-in-use') {

        SnackBarService.showSnackBar(
            context,
            'The account already exists for that email.',
          true,
        );
      } else {
        SnackBarService.showSnackBar(
          context,
          'Unknown error! Error code: ${e.code}', // Выводим код ошибки в SnackBar

          true,
        );
      }
    }
    navigator.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  Future<void> register1() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  SignUpScreen()),
    );
  }
//
  Widget _login() {
    return Padding(
      padding: EdgeInsets.only(top: 100),
      child: Container(
        child: Align(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(70),
                topLeft: Radius.circular(70),
              ),
              color: Colors.white,
              border: Border.all(color: Colors.purple.shade300, width: 13),
            ),
            child: Column(
              children: [
                Text(
                  "SMART",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                    letterSpacing: 6,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "IELTS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    letterSpacing: 3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _input(
      Icon icon,
      String string,
      TextEditingController controller,
      bool obscure,
      ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        color: Colors.purple.shade300,
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(60),
            topLeft: Radius.circular(60),
          ),
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
                bottomRight: Radius.circular(60),
                topLeft: Radius.circular(60),
              ),
              borderSide: BorderSide(width: 3, color: Colors.purple.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(60),
                topLeft: Radius.circular(60),
              ),
              borderSide: BorderSide(width: 1.5, color: Colors.purple.shade300),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: IconTheme(
                data: IconThemeData(color: Colors.deepPurple),
                child: icon,
              ),
            ),
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          ),
        ),
      ),
    );
  }
  //_loginController
  //_passwordController
  Widget _form(String label, void Function() function) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 40),
            child: _input(
              Icon(Icons.login, size: 40),
              "123@gmail.com",
              _loginController,
              false,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _input(
              Icon(Icons.key, size: 40),
              "********",
              _passwordController,
              true,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: function,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade300,
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _login(),
            SizedBox(
              height: 20,
            ),
            (showLogin
                ? Column(
              children: <Widget>[
                _form("Log in", login),
                //
                if (showResetPasswordButton)
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      child: Text(
                        "Forgot Password? Reset Here",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      onPressed: resetPassword,
                    ),
                  ),
                //
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextButton( //
                    child: Text(
                      "Not logged in? Sign up!",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    onPressed: () { //
                      setState(() {
                        showLogin = false;
                      });
                    },
                  ),
                )

              ],
            )
                : Column(
              children: <Widget>[
                _form("Sign up", () { //
                  register();
                }),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextButton( //
                    child: Text(
                      "Signed up? Log in!",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    onPressed: () { //
                      setState(() {
                        showLogin = true;
                      });
                    },
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
