import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      throw e;
    }
  }

  Future<void> sendPasswordResetEmail(String matricola) async {
    try {
      final auth = FirebaseAuth.instance;
      final matriculation = "s$matricola@studenti.univpm.it";

      await auth.sendPasswordResetEmail(email: matriculation);
    } catch (e) {
      throw e;
    }
  }

}
