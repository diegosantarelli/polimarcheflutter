import 'package:flutter/material.dart';
import 'package:polimarcheflutter/screens/setup/setupListScreen.dart';

/*
* Mostra una lista di "setups" utilizzando il widget SetupListScreen.
* L'aspetto della schermata include un'immagine di sfondo con un effetto
* di oscuramento, un'app bar con il titolo "Setups" e una barra di
* navigazione inferiore con due elementi: "Home" e "Setups"
*/

class SetupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sfondo_schermata_setup.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
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
                  'Setups',
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
            BottomNavigationBarItem(
            icon: GestureDetector(
            child: Image.asset(
                'assets/images/setup_black.png',
                width: 20,
                height: 20,
              ),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/setup',
                      (route) => false, // Rimuove tutte le pagine nella pila delle route
                );
              },
            ),
            label: 'Setups',
            ),
          ],
        ),
      ),
    );
  }
}
