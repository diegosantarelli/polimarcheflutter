import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
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

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logobianco.png',
              width: 200,
              height: 200,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'aldrich',
              ),
            ),
            ),
            SizedBox(height: 15),
            TextFormField(
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
            ),
            SizedBox(height: 10),
            TextFormField(
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
            ),
            SizedBox(height: 15),
            TextButton(
              onPressed: () {},
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
        )
      )
    );
  }
}
