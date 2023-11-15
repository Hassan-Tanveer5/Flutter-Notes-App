import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteNoteWidget extends StatefulWidget {
  final title;
  final content;

  DeleteNoteWidget({
    required this.title,
    required this.content,
  });

  @override
  State<DeleteNoteWidget> createState() => _DeleteNoteWidgetState();
}

class _DeleteNoteWidgetState extends State<DeleteNoteWidget> {
  //To update the task
  Future<void> deleteTask() async {
    final taskSnapshot = await FirebaseFirestore.instance
        .collection('notes')
        .where('userid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where('title', isEqualTo: widget.title)
        .where('content', isEqualTo: widget.content)
        .get();

    if (taskSnapshot.docs.isNotEmpty) {
      final docID = taskSnapshot.docs.first.id;

      try {
        await FirebaseFirestore.instance
            .collection('notes')
            .doc(docID)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Document deleted successfully.'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task not found!'),
        ),
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('Do you want to remove the item from the list'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No')),
        TextButton(
            onPressed: () {
              deleteTask();

              Navigator.of(context).pop();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Document deleted successfully.'),
                ),
              );
            },
            child: const Text('Yes')),
      ],
    );
  }
}
