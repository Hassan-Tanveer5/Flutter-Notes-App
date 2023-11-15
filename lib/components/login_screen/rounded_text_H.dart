import 'package:flutter/material.dart';

import '../../constants.dart';

class RoundedText extends StatelessWidget {
  final text;
  RoundedText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 40,
        fontFamily: 'Bitter',
        fontWeight: FontWeight.w500,
        color: kPrimaryColor,
      ),
    );
  }
}
