import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:notes_app/screens/login_screen.dart';

import '../components/login_screen/rounded_button.dart';
import '../components/login_screen/rounded_input.dart';
import '../components/login_screen/rounded_password.dart';
import '../components/login_screen/rounded_suHead.dart';
import '../components/login_screen/rounded_text_H.dart';
import '../components/login_screen/swap_screen_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  //Firebase authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    //For signup a new user
    void signUpUserWithEmailAndPassword() async {
      //Show Loading circle
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      try {
        await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Send email verification
        final user = _auth.currentUser;
        if (user != null) {
          await user.sendEmailVerification();

          // Show a success message or navigate to a verification screen
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Verification email sent. Check your inbox."),
            ),
          );
          Navigator.of(context).pop();
        }
      } catch (e) {
        // Handle the error and provide feedback to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error during sign-up: $e")),
        );
      }
    }

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

              RoundedText(text: 'Sign Up Now'),

              RoundedSubheading(text: 'Sign Up to create an account'),

              const SizedBox(height: 10),

              //For Username
              RoundedInput(
                controller: userNameController,
                icon: Icons.supervised_user_circle,
                hint: 'Username',
              ),

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

              const SizedBox(height: 10),

              //For Login Button
              RoundedButton(
                title: 'Create Account',
                ontaps: signUpUserWithEmailAndPassword,
              ),

              const SizedBox(height: 10),

              //To navigate to signupPage

              SwapScreen(
                mtext: 'Already have an account!',
                btext: 'Login',
                ontap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
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
