import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'AuthScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp()
      .then((value) => print(value.options.projectId));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(background: Colors.white),
        fontFamily: 'Ubuntu',),
      home: AuthScreen(),
    );
  }
}