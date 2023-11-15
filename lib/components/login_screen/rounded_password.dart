import 'package:flutter/material.dart';
import '../../constants.dart';
import './input_container.dart';

class RoundedPasswordInput extends StatefulWidget {
  final String hint;
  final controller;

  RoundedPasswordInput({
    required this.hint,
    required this.controller,
  });

  @override
  State<RoundedPasswordInput> createState() => _RoundedPasswordInputState();
}

class _RoundedPasswordInputState extends State<RoundedPasswordInput> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
        controller: widget.controller,
        cursorColor: kPrimaryColor,
        obscureText: _obscured,
        focusNode: textFieldFocusNode,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock, color: kPrimaryColor),
          hintText: widget.hint,
          border: InputBorder.none,
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: GestureDetector(
              onTap: _toggleObscured,
              child: Icon(
                _obscured
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
