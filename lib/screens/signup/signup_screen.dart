import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatelessWidget {

  // Viene ottenuta l'istanza di FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Viene ottenuta l'istanza di FirebaseFirestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Vengono impostati dei controller sugli elementi di input TextField
  TextEditingController matricolaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confermapwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sfondo_schermata_login.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logobianco.png',
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: matricolaController,
                      decoration: InputDecoration(
                        hintText: 'Matricola',
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.black,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'aldrich',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.black,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,

                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: confermapwController,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.black,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        print("Sign Up button pressed");
                        String matricola = matricolaController.text;
                        String email = "s" + matricola + "@studenti.univpm.it";// Ottieni il valore della email dal campo di testo
                        String password = passwordController.text;// Ottieni il valore della password dal campo di testo
                        String confermapw = confermapwController.text;

                        registerUser(context, email, password, confermapw);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'aldrich',
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF9A9A9A),
                        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton (
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'aldrich',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ),
        ),
    );
  }

  void registerUser(BuildContext context, String email, String password, String confirmPassword) async {
    print("Registering user");
    try {
      if (password != confirmPassword) {
        // Le password non corrispondono, gestisci l'errore qui
        print('Le password non corrispondono');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Le password non corrispondono'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (password.length < 6) {
        // La password deve essere di almeno 6 caratteri, gestisci l'errore qui
        print('La password deve essere di almeno 6 caratteri');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('La password deve essere di almeno 6 caratteri'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Creazione dell'utente nel database Firestore
        await _firestore.collection('Users').doc(userCredential.user!.uid).set({
          'matriculation': email,
          'password': password,
          'role': "Department head",
        });

        // Navigazione verso la schermata di login dopo la registrazione
        Navigator.pushNamed(context, '/home');
      }
    } catch (e) {
      print('Errore durante la registrazione: $e');
      if (e is FirebaseAuthException) {
        // Gestisci gli errori specifici di FirebaseAuthException
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('L\'email è già in uso. Si prega di utilizzare un\'altra email.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // Gestisci gli altri errori
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore durante la registrazione: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      // Gestisci l'errore di registrazione qui
    }
  }



}

