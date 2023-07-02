import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController matricolaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logobianco.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: matricolaController,
                    decoration: InputDecoration(
                      hintText: 'Matricola',
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      String matricola = matricolaController.text;
                      String email = "s" + matricola + "@studenti.univpm.it";
                      String password = passwordController.text;
                      _signInWithEmailAndPassword(context, email, password);
                    },
                    child: Text('Sign In'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[700],
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'aldrich',
                      ),
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: 'aldrich',
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      String matricola = matricolaController.text;
                      sendPasswordResetEmail(context, matricola);
                    },
                    child: Text(
                      'Password recovery',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
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

  Future<void> _signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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

  void sendPasswordResetEmail(BuildContext context, String matricola) async {
    try {
      final auth = FirebaseAuth.instance;
      final matriculation = "s$matricola@studenti.univpm.it";

      await auth.sendPasswordResetEmail(email: matriculation);

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