import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polimarcheflutter/screens/tracks/trackList_screen.dart';

class TrackScreen extends StatelessWidget {

  // Nel metodo build, viene costruita l'interfaccia utente.
  // Viene utilizzato un Scaffold come contenitore principale,
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Rimuove la freccia per tornare indietro
        backgroundColor: Colors.black,
        elevation: 0,
        title: Center(
          child: Text(
            'Tracks',
            style: TextStyle(
              fontSize: 34,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Aldrich',
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sfondo_schermata_circuiti.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            //l'Expanded permette di far prendere al child tutto lo spazio del Column
            Expanded(
              //andiamo a richiamare la classe TracksListScreen che contiene la lista delle track
              child: TracksListScreen(),
            ),
          ],
        ),
      ),
      //Definiamo la BottomNavigationBar con le icone della home e add track
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              //Occorre utilizzare GestureDetector poiché la BottomNavigationBar non permette di
              //rilevare gli eventi
              icon: GestureDetector(
                child: Image.asset(
                  'assets/images/home.png',
                  width: 20,
                  height: 20,
                ),
                //la funzione onTap() mi permette di gestire l'evento che si deve verificare
                //al click sull'icona
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              //Occorre utilizzare GestureDetector poiché la BottomNavigationBar non permette di
              //rilevare gli eventi
              icon: GestureDetector(
                child: Image.asset(
                  'assets/images/add.png',
                  width: 22,
                  height: 22,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/addtrack');
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
