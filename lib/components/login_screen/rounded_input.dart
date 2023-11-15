import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

import 'input_container.dart';

class RoundedInput extends StatelessWidget {
  final controller;
  final icon;
  final hint;
  const RoundedInput({
    required this.controller,
    required this.icon,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
        controller: controller,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(icon, color: kPrimaryColor),
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
