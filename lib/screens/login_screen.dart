// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/components/login_screen/forget_text.dart';
import 'package:notes_app/components/login_screen/rounded_button.dart';
import 'package:notes_app/components/login_screen/rounded_input.dart';
import 'package:notes_app/components/login_screen/rounded_password.dart';
import 'package:notes_app/components/login_screen/rounded_suHead.dart';
import 'package:notes_app/components/login_screen/rounded_text_H.dart';
import 'package:notes_app/components/login_screen/swap_screen_text.dart';
import 'package:notes_app/screens/main_screen.dart';
import 'package:notes_app/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //To resend email verification
  Future<void> sendEmailVerification(User user) async {
    await user.sendEmailVerification();
  }

  //To signiin user
  Future<void> signInUser() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null && user.emailVerified) {
        // User is signed in and their email is verified.
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      } else if (user != null && !user.emailVerified) {
        // User is signed in, but their email is not verified.
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Email Not Verified'),
              content: const Text(
                  'Please check your email and verify your account.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    sendEmailVerification(user);
                  },
                  child: const Text('Resend Verification Email'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Sign-in failed.
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Sign In Failed'),
            content: const Text('Please check your email and password.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  height: screenHeight * 0.4,
                  width: screenWidth * 0.8,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Image.asset(
                    'assets/images/login.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 5),

              RoundedText(text: 'Sign In Now'),

              RoundedSubheading(text: 'Sign in to continue using the app'),

              const SizedBox(height: 10),
              //For Email
              RoundedInput(
                controller: emailController,
                icon: Icons.email,
                hint: 'Email',
              ),

              //For password
              RoundedPasswordInput(
                hint: 'Password',
                controller: passwordController,
              ),

              //For Forget Password
              ForgetPasswordText(),

              const SizedBox(height: 10),

              //For Login Button
              RoundedButton(
                title: 'Login',
                ontaps: signInUser,
              ),

              const SizedBox(height: 10),

              //To navigate to signupPage
              SwapScreen(
                mtext: 'Do not have an account!',
                btext: 'Create Account',
                ontap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
