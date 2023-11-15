import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/components/home_screen/gridview_tile.dart';
import 'package:notes_app/screens/add_note_screen.dart';
import 'package:notes_app/screens/auth_screen.dart';

import '../components/home_screen/drawer_container.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //For signing user out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => AuthScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kPrimaryColor.withOpacity(0.2),
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddNoteScreen(),
                ),
              );
            },
            icon: const Icon(Icons.note_add),
          ),
        ],
      ),
      //For navogation drawer
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 25, 110, 180),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset(
                      'assets/images/notes.png',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Notes Hub',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            //For add task
            DrawerTile(
              icon: Icons.add_task,
              text: 'Add Note',
              ontaps: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddNoteScreen(),
                  ),
                );
              },
            ),

            //For Logout
            DrawerTile(
              icon: Icons.logout,
              text: 'Logout',
              ontaps: signUserOut,
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          //color: Colors.transparent,
          width: double.infinity,
          child: HomeNotesGrid(),
        ),
      ),
    );
  }
}
