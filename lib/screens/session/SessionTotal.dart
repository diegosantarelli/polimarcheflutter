import 'package:flutter/material.dart';
import 'package:polimarcheflutter/screens/setup/setupListScreen.dart';

class PracticeSessionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sfondo_schermata_practice_session.jpg'),
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
              child: SetupListScreen(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/track.png',
                width: 20,
                height: 20,
              ),
              label: 'Setups',
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

class ImageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget image;
  final Color color;

  ImageButton({required this.onPressed, required this.image, required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: image,
          ),
        ),
      ),
    );
  }
}
