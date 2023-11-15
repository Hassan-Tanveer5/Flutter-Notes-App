import 'package:flutter/material.dart';
import '../../constants.dart';
import 'rounded_suHead.dart';

class SwapScreen extends StatelessWidget {
  final mtext;
  final btext;
  final ontap;
  const SwapScreen({
    required this.mtext,
    required this.btext,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedSubheading(text: mtext),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: ontap,
          child: Text(
            btext,
            style: const TextStyle(
              color: kPrimaryColor,
              fontSize: 16,
              fontFamily: 'Bitter',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
