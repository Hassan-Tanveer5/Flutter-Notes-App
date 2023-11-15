import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

class InputContainer extends StatelessWidget {
  final Widget child;
  const InputContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kPrimaryColor.withAlpha(50),
        border: Border.all(
          color: kPrimaryColor,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
