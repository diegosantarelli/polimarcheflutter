import 'package:flutter/material.dart';

class TrackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sfondo_schermata_circuiti.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Tracks',
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aldrich',
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xBF000000),
                ),
                child: Placeholder(), // Replace with your actual content
              ),
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
              label: 'Tracks',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                  'assets/images/bin.png',
                   width: 20,
                   height: 20,
              ),
              label: 'Delete',
            ),
          ],
        ),
      ),
    );
  }
}
