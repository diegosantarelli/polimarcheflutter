import 'package:flutter/material.dart';
import 'package:polimarcheflutter/screens/session/sessionList.dart';


class PracticeSessionScreen extends StatelessWidget {

  /* Viene costruita l'interfaccia utente della schermata.
   È composta da un Scaffold con uno sfondo decorato,
  una colonna di widget e una barra di navigazione inferiore (BottomAppBar)

  La barra superiore contiene un'app Bar personalizzata con il titolo "Practice Sessions"

  La colonna di widget contiene due elementi: il primo è un contenitore con margine superiore,
  che fornisce spazio sopra l'app Bar. Il secondo elemento è ListPracticeSessionScreen(),
  che viene utilizzato per visualizzare l'elenco delle sessioni di pratica

  La barra inferiore (BottomAppBar) contiene un BottomNavigationBar con due voci,
  "Home" e "Add
  */
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
              margin: EdgeInsets.only(top: 20),
              child: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text(
                  'Practice Sessions',
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
                  'assets/images/add.png',
                  width: 20,
                  height: 20,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/addsession');
                },
              ),
              label: 'Add',
            ),
          ],
        ),
      ),
    );
  }
}
