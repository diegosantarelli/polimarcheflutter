import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Questa classe è utilizzata per memorizzare i dati dell'utente recuperati dal database Firebase
class UserData extends ChangeNotifier {
  String matriculation = '';
  String role = '';

  // Metodo responsabile del recupero dei dati dell'utente dal database Firestore.
  // Utilizza l'ID dell'utente fornito per recuperare il documento corrispondente dall'insieme "Users".
  // Se il documento esiste, vengono estratti i dati e assegnati alle proprietà matriculation e role.
  // Se il documento non esiste, le proprietà vengono lasciate vuote.
  // Infine, il metodo notifyListeners() viene chiamato per avvisare gli ascoltatori
  // che i dati sono stati aggiornati.
  Future<void> fetchDataFromFirebase(String userId) async {
    try {
      DocumentSnapshot userDocument = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

      if (userDocument.exists) {
        Map<String, dynamic> userData = userDocument.data() as Map<String, dynamic>;
        matriculation = userData['matriculation'] ?? '';
        role = userData['role'] ?? '';
      } else {
        // Il documento utente non esiste nel database
      }
    } catch (error) {
      print('Errore durante il recupero dei dati: $error');
    }

    notifyListeners();
  }
// Utilizzato per estrarre la matricola dall'indirizzo email dell'utente
  String? getMatricolaFromEmail(String email) {
    RegExp regex = RegExp(r'\d+');
    Match match = regex.firstMatch(email) as Match;
    if (match != null) {
      return match.group(0);
    } else {
      return 'Matricola non trovata';
    }
  }

}
/*
class HomeScreenUp extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenUp> {
  final UserData userData = UserData();
  late FirebaseAuth _auth;

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
    );
  }
}

*/
