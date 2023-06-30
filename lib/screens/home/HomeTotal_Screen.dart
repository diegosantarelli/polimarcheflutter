import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:polimarcheflutter/screens/home/homeUp_screen.dart'; // Importa la nuova classe HomeScreenDown

class HomeTotal extends StatefulWidget {
  @override
  _HomeTotalState createState() => _HomeTotalState();
}

class _HomeTotalState extends State<HomeTotal> {
  final UserData userData = UserData();
  late FirebaseAuth _auth;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    String userId = _auth.currentUser?.uid ?? '';
    userData.fetchDataFromFirebase(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sfondo_schermata_home.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                // FrameLayout
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'aldrich',
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          userData.matriculation,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'aldrich',
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          userData.role,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'aldrich',
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 2,
                          color: Colors.white,
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 2,
                          color: Colors.white,
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Menu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'aldrich',
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/setup.png',
                                      width: 40,
                                      height: 40,
                                      color: Colors.black,
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Setup',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'aldrich',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/mechanic.png',
                                      width: 40,
                                      height: 40,
                                      color: Colors.black,
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Session',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'aldrich',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/track.png',
                                      width: 40,
                                      height: 40,
                                      color: Colors.black,
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Tracks',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'aldrich',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            FloatingActionButton(
              onPressed: () {
                // Handle floating action button tap
              },
              child: Icon(Icons.menu),
              backgroundColor: Colors.grey,
              elevation: 10,
            ),
            IconButton(
              icon: Image.asset(
                'assets/images/group.png',
                width: 30,
                height: 30,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

