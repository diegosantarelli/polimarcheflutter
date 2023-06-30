import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:polimarcheflutter/screens/home/homeUp_screen.dart';

import 'package:polimarcheflutter/screens/home/homeUp_screen.dart'; // Importa la nuova classe HomeScreenDown

class HomeTotal extends StatefulWidget {
  @override
  _HomeTotalState createState() => _HomeTotalState();
}

class _HomeTotalState extends State<HomeTotal> {
  final UserData userData = UserData();
  late FirebaseAuth _auth;
  late String userId; // Variabile per memorizzare userId
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    userId = _auth.currentUser?.uid ?? '';
    fetchDataFromFirebase(userId);
  }

  Future<void> fetchDataFromFirebase(String userId) async {
    await userData.fetchDataFromFirebase(userId);
    setState(() {}); // Aggiorna il widget dopo il recupero dei dati
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
                        FutureBuilder<void>(
                          future: userData.fetchDataFromFirebase(userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Mostra uno spinner di caricamento
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // Gestisci l'errore durante il recupero dei dati
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // I dati sono stati recuperati correttamente
                              return Column(
                                children: [
                                  Text(
                                    userData.matriculation.split("@")[0].substring(1),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'aldrich',
                                    ),
                                  ),

                                  SizedBox(height: 20),
                                  Text(
                                    userData.role,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
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
                                      fontSize: 25,
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
                                            color: Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/setup.png',
                                                width: 40,
                                                height: 40,
                                                color: Colors.white,
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                'Setup',
                                                style: TextStyle(
                                                  color: Colors.white,
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
                                            color: Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/mechanic.png',
                                                width: 40,
                                                height: 40,
                                                color: Colors.white,
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                'Session',
                                                style: TextStyle(
                                                  color: Colors.white,
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
                                            color: Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/track.png',
                                                width: 40,
                                                height: 40,
                                                color: Colors.white,
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                'Tracks',
                                                style: TextStyle(
                                                  color: Colors.white,
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
                              );
                            }
                          },
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
