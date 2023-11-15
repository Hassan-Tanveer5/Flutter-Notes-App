import 'package:flutter/material.dart';
import 'package:notes_app/screens/forget_password_screen.dart';

class ForgetPasswordText extends StatelessWidget {
  ForgetPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ForgetPasswordScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 45),
        child: const Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Forget Password',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            )),
      ),
    );
  }
}
