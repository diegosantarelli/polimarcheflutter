import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarcheflutter/models/user_model.dart';

class SignUpViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController matricolaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confermapwController = TextEditingController();

  void registerUser(BuildContext context) async {
    print("Registering user");
    try {
      final String matricola = matricolaController.text;
      final String email = "s$matricola@studenti.univpm.it";
      final String password = passwordController.text;
      final String confirmPassword = confermapwController.text;

      if (password != confirmPassword) {
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
        await _firestore.collection('Users').doc(userCredential.user!.uid).set({
          'matriculation': email,
          'password': password,
          'role': "Department head",
        });

        Navigator.pushNamed(context, '/home');
      }
    } catch (e) {
      print('Errore durante la registrazione: $e');
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('L\'email è già in uso. Si prega di utilizzare un\'altra email.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore durante la registrazione: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
