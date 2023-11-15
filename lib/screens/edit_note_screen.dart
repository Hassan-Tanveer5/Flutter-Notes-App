import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/delete_note_screen.dart';

//import '../components/add_note_screen/popup_menu.dart';
import '../constants.dart';

class EditNoteScreen extends StatefulWidget {
  final title;
  final content;
  EditNoteScreen({
    required this.title,
    required this.content,
  });

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  //Text editing controllers
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  //Getting inastance of firebase current user
  final user = FirebaseAuth.instance.currentUser?.uid;

  //To set values in the fields
  @override
  void initState() {
    titleController.text = widget.title;
    contentController.text = widget.content;
    super.initState();
  }

  //Function to update the task
  Future<void> updateNote() async {
    //getting the snapshot of data from firebase
    final taskSnapshot = await FirebaseFirestore.instance
        .collection('notes')
        .where('userid', isEqualTo: user)
        .where('title', isEqualTo: widget.title)
        .where('content', isEqualTo: widget.content)
        .get();

    if (taskSnapshot.docs.isNotEmpty) {
      final taskDoc = taskSnapshot.docs.first;
      final taskId = taskDoc.id;

      // Update the task in Firestore
      await FirebaseFirestore.instance.collection('notes').doc(taskId).update({
        'userid': user,
        'title': titleController.text,
        'content': contentController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Task updated successfully!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
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
    //To get approperiate screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //For Custom Appbar
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 25, 110, 180),
                ),
                height: screenHeight * 0.08,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    //For Title Text
                    SizedBox(
                      width: screenWidth * 0.7,
                      child: TextField(
                        controller: titleController,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Bitter',
                        ),
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Enter Title',
                          hintStyle: TextStyle(color: Colors.white70),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    //Menu Icon in custom appbar
                    //const CustomPopUpMenuButton(),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DeleteNoteWidget(
                              title: widget.title,
                              content: widget.content,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              //For content
              Container(
                height: screenHeight * 0.8,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                color: kPrimaryColor.withAlpha(30),
                child: TextField(
                  controller: contentController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  maxLines: 40,
                  decoration: const InputDecoration(
                    hintText: 'Enter content',
                    border: InputBorder.none,
                  ),
                ),
              ),

              //To save note
              Container(
                height: screenHeight * 0.091,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                color: kPrimaryColor.withAlpha(30),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    onPressed: updateNote,
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.save),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
