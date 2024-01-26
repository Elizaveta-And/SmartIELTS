import 'package:flutter/material.dart';
import 'AuthScreen.dart';
//
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth/account_screen.dart';
import 'package:flutter_course/Homescreen.dart';
//import 'auth/login_screen.dart';
import 'auth/reset_password_screen.dart';
import 'auth/signup_screen.dart';
import 'auth/verify_email_screen.dart';
import 'services/firebase_streem.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(background: Colors.white),
        fontFamily: 'Ubuntu',),
      //home: const AuthScreen(),
      routes: {
        '/': (context) => const FirebaseStream(),
        '/home': (context) => IeltsSmart(),
        '/account': (context) => const AccountScreen(),
        '/login': (context) => const AuthScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/reset_password': (context) => const ResetPasswordScreen(),
        '/verify_email': (context) => const VerifyEmailScreen(),
      },
      initialRoute: '/login',
    );
  }
}