import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/services/snack_bar.dart';
import 'package:flutter_course/HomeScreen.dart';
import 'package:flutter_course/AuthScreen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
            (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IeltsSmart()),
      );
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));

      setState(() => canResendEmail = true);
    } catch (e) {
      print(e);
      if (mounted) {
        SnackBarService.showSnackBar(
          context,
          '$e',
          //'Unknown error! Try again or contact support.',
          true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ?  IeltsSmart()
      : Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      elevation: 10,
      centerTitle: true,
      backgroundColor: Colors.purple.shade200,
      titleSpacing: 0,
      title: Text("Verification of the Email",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
    ),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'A confirmation email has been sent to your email address.',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: canResendEmail ? sendVerificationEmail : null,
              icon:  Icon(Icons.email, color: Colors.purple.shade300,),
              label: Text('Resend', style: TextStyle(color: Colors.purple.shade300),),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                timer?.cancel();
                await FirebaseAuth.instance.currentUser!.delete();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.purple.shade300,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                );},
              child: Text(
                'Back',
                style: TextStyle(
                  color: Colors.purple.shade300,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
