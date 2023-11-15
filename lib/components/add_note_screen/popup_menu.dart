import 'package:flutter/material.dart';

class CustomPopUpMenuButton extends StatelessWidget {
  final uid;
  final title;
  final content;
  const CustomPopUpMenuButton({
    required this.uid,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: (value) {
        /*if (value == "Edit") {
          // add desired output
        } else*/
        if (value == "Delete") {
          // add desired output
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        /*const PopupMenuItem(
          value: "Edit",
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.edit),
              ),
              Text(
                'Edit',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),*/
        const PopupMenuItem(
          value: "Delete",
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.settings),
              ),
              Text(
                'Delete',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
