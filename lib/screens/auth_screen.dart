import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/login_screen.dart';
import 'package:notes_app/screens/main_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //To check weather user is signed in or not
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //If user is logged in
          if (snapshot.hasData) {
            return MainScreen();
          }
          //User is not logged in
          else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
