import 'package:flutter/material.dart';

import '../models/authentication_model.dart';
import '../view/login_screen.dart';

class LoginViewModel {
  final AuthenticationModel _authenticationModel = AuthenticationModel();

  Future<void> signIn(BuildContext context, String matricola, String password) async {
    String email = "s$matricola@studenti.univpm.it";

    try {
      await _authenticationModel.signInWithEmailAndPassword(email, password);
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Errore di accesso'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    String matricola = LoginScreen().matricolaController.text;

    try {
      await _authenticationModel.sendPasswordResetEmail(matricola);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email di recupero password inviata'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      String errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
