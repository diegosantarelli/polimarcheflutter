import 'package:flutter/material.dart';

class HomeScreenDown extends StatelessWidget {
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
            Container(
              // CoordinatorLayout
              child: BottomAppBar(
                child: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      label: 'Favorites',
                    ),
                  ],
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                // Handle floating action button tap
              },
              child: Icon(Icons.menu),
              backgroundColor: Colors.grey,
              elevation: 10,
            ),
          ],
        ),
      ),
    );
  }
}
