import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/edit_note_screen.dart';
import '../../constants.dart';

class HomeNotesGrid extends StatefulWidget {
  HomeNotesGrid({super.key});

  @override
  State<HomeNotesGrid> createState() => _HomeNotesGridState();
}

class _HomeNotesGridState extends State<HomeNotesGrid> {
  // list of tile colors
  /*final List<Color> tileColors = [
    const Color.fromARGB(255, 255, 146, 138),
    Colors.blue,
    const Color.fromARGB(255, 148, 228, 151),
    const Color.fromARGB(255, 252, 238, 120),
    // Add more colors as needed
  ];*/

  //List of images
  // List of asset paths for background images
  List<String> backgroundImages = [
    'assets/images/b1.jpg',
    'assets/images/b2.jpg',
    'assets/images/b3.jpg',
    'assets/images/b4.jpg',
    // Add more image paths as needed
  ];

  // Index to track the current background image
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      //backgroundColor: kPrimaryColor.withAlpha(30),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notes')
            .where('userid', isEqualTo: user)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Column(
              children: [
                //If no data exist
                Image.asset('assets/images/message.jpg'),
                const Center(
                  child: Text(
                    'No notes added try adding some.',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Bitter',
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          }

          var documents = snapshot.data?.docs;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: documents?.length,
            itemBuilder: (context, index) {
              var document = documents?[index];
              var data = document?.data();

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditNoteScreen(
                        title: data?['title'],
                        content: data?['content'],
                      ),
                    ),
                  );
                },
                child: GridTile(
                  footer: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(
                        data?['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Bitter',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      //color: tileColors[index % tileColors.length],
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(backgroundImages[
                              index % backgroundImages.length]),
                          fit: BoxFit.cover, // You can adjust the fit as needed
                        ),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 10,
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          data?['content'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Bitter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
