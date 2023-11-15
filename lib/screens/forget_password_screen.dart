import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/login_screen/rounded_button.dart';
import '../components/login_screen/rounded_input.dart';
import '../constants.dart';

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  void resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Email sent'),
            content: const Text(
                'We have sent you a password reset request on your provided email'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Something went wrong!'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('Forget Password'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          height: double.infinity,
          color: kPrimaryColor.withOpacity(0.2),
          child: Column(
            children: [
              //For decoration
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Image.asset('assets/images/notes.png'),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  /*   border: Border.all(
                    color: kPrimaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),*/
                  color: kPrimaryColor.withOpacity(0.1),
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Notes Hub',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'PlayfairDisplay-Bold',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RoundedInput(
                icon: Icons.mail,
                hint: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 10),
              RoundedButton(
                title: 'Reset Password',
                ontaps: resetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
