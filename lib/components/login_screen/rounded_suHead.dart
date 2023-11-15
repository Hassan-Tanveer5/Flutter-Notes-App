import 'package:flutter/material.dart';

class RoundedSubheading extends StatelessWidget {
  final text;
  RoundedSubheading({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 17,
        fontFamily: 'Bitter',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
