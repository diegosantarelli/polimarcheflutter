import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  // Istanza di FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Vengono dichiarati due controller per i campi di testo,
  // uno per la matricola e uno per la password
  TextEditingController matricolaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Nel metodo build, viene costruita l'interfaccia utente.
  // Viene utilizzato un Scaffold come contenitore principale,
  // con uno sfondo decorato e una colonna di widget al centro.
  //
  // Vengono aggiunti due campi di testo per la "matricola" e la password,
  // con gli stili e le opzioni di decorazione.
  //
  // Ci sono tre pulsanti: "Sign In" per effettuare l'accesso,
  // "Sign Up" per registrarsi e
  // "Password recovery" per richiedere il ripristino della password
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

  // Il metodo _signInWithEmailAndPassword viene chiamato
  // quando l'utente preme il pulsante "Sign In". Questo metodo utilizza l
  // 'istanza _auth per effettuare l'autenticazione con l'email e la password fornite.
  // Se l'autenticazione è riuscita, l'app passerà alla schermata "/home",
  // altrimenti verrà visualizzato un messaggio di errore in un AlertDialog
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

  // Il metodo sendPasswordResetEmail viene chiamato quando
  // l'utente preme il pulsante "Password recovery". Questo metodo invia un'email
  // di recupero password all'indirizzo specificato, utilizzando l'istanza _auth.
  // Se l'operazione ha successo, viene visualizzato un messaggio di conferma,
  // altrimenti un messaggio di errore.
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