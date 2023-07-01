import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polimarcheflutter/screens/tracks/trackList_screen.dart';

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
              child: TracksListScreen(),
            ),
          ],
        ),
      ),
    );
  }
}