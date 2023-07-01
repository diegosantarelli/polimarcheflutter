import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class SetupScreen extends StatelessWidget {
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
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Text(
                      'Setup',
                      style: TextStyle(
                        fontSize: 34,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'aldrich',
                      ),
                    ),
                    SizedBox(height: 20),
                    IconButton(
                      icon: Image.asset('assets/back_icon.png'),
                      onPressed: () {
                        // Aggiungi il gestore per il pulsante back
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xBF000000),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Placeholder(), // Sostituisci con il contenuto effettivo del FrameLayout
              ),
            ),
            BottomAppBar(
              child: BottomNavigationBar(
                items: [
                  // Aggiungi gli elementi del menu
                ],
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
