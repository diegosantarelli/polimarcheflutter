import 'package:flutter/material.dart';

class HomeScreenDown extends StatefulWidget {
  @override
  _HomeScreenDownState createState() => _HomeScreenDownState();
}

class _HomeScreenDownState extends State<HomeScreenDown> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sfondo_schermata_home.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                // FrameLayout
                child: Placeholder(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            FloatingActionButton(
              onPressed: () {
                // Handle floating action button tap
              },
              child: Icon(Icons.menu),
              backgroundColor: Colors.grey,
              elevation: 70,
            ),
            IconButton(

              icon: Icon(Icons.favorite),
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
