import 'package:flutter/material.dart';

import '../../constants.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? ontaps;
  DrawerTile({
    required this.icon,
    required this.text,
    required this.ontaps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kPrimaryColor.withAlpha(50),
        border: Border.all(color: kPrimaryColor, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.deepPurple,
        ),
        title: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        onTap: ontaps,
      ),
    );
  }
}
