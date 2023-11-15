import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

class AddNoteScreen extends StatefulWidget {
  AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  //Text editing controllers
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  //Getting inastance of firebase current user
  final User? user = FirebaseAuth.instance.currentUser;

  //Adding Note to Firestore
  addNoteToFirestore() {
    //Storing data in the database
    final db = FirebaseFirestore.instance;
    Map<String, dynamic> mymap = {
      'userid': FirebaseAuth.instance.currentUser!.uid,
      'title': titleController.text,
      'content': contentController.text,
    };
    setState(() {
      db.collection('notes').add(mymap);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Note Added Successfully"),
      ),
    );
    //To return to home screen
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {
                      //Storing data in the database
                      final db = FirebaseFirestore.instance;
                      Map<String, dynamic> mymap = {
                        'userid': FirebaseAuth.instance.currentUser!.uid,
                        'title': titleController.text,
                        'content': contentController.text,
                      };
                      setState(() {
                        db.collection('notes').add(mymap);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Note Added Successfully"),
                        ),
                      );
                      //To return to home screen
                      Navigator.of(context).pop();
                    },
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
