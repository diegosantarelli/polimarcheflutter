import 'package:flutter/material.dart';
import 'package:polimarcheflutter/screens/session/sessionList.dart';
import 'package:polimarcheflutter/screens/setup/setupListScreen.dart';

class PracticeSessionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sfondo_schermata_setup.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20), // Spostamento verso il basso
              child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Practice Session',
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aldrich',
                ),
              ),
            ),
            ),
            Expanded(
              child: ListPracticeSessionScreen(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/mechanic.png',
                width: 20,
                height: 20,
              ),
              label: 'Practice Sessions',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                child: Image.asset(
                  'assets/images/home.png',
                  width: 20,
                  height: 20,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              label: 'Home',
            ),
          ],
        ),
      ),
    );
  }
}

