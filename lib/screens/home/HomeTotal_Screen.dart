import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'homeUp_screen.dart';

// Classe rappresenta un widget personalizzato per un menu
// a comparsa. Utilizza il widget IconButton
// per mostrare l'icona del menu e apre il drawer quando viene premuto
class CustomPopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        // Mostra il drawer del menu a tutto schermo
        Scaffold.of(context).openDrawer();
      },
    );
  }
}

// Classe principale che rappresenta la schermata principale
class HomeTotal extends StatefulWidget {
  @override
  _HomeTotalState createState() => _HomeTotalState();
}

// Classe di stato associata al widget HomeTotal
class _HomeTotalState extends State<HomeTotal> {
  // Istanza di una classe UserData
  // FINAL viene utilizzata per dichiarare variabili che possono
  // essere inizializzate solo una volta e poi non possono
  // essere riassegnate a un nuovo valore
  final UserData userData = UserData();
  // Istanza della classe FirebaseAuth
  late FirebaseAuth _auth;
  late String userId; // Variabile per memorizzare userId
  int _currentIndex = 0;
  late String dropdownValue = 'Option 1';

  // Inizializza l'autenticazione Firebase e recupera i dati da Firebase per l'utente corrente
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    userId = _auth.currentUser?.uid ?? '';
    fetchDataFromFirebase(userId);
  }

  // Metodo che recupera i dati da Firebase per il userId fornito
  Future<void> fetchDataFromFirebase(String userId) async {
    await userData.fetchDataFromFirebase(userId);
    setState(() {}); // Aggiorna il widget dopo il recupero dei dati
  }

  // Il metodo principale che costruisce l'interfaccia utente per la schermata principale.
  // Include un Scaffold con un'immagine di sfondo e vari componenti dell'interfaccia
  // utente come testi, immagini e container
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sfondo_schermata_home.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                // FrameLayout
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        SizedBox(height: 40),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'aldrich',
                          ),
                        ),
                    ),
                        SizedBox(height: 20),
                        FutureBuilder<void>(
                          future: userData.fetchDataFromFirebase(userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Mostra uno spinner di caricamento
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // Gestisci l'errore durante il recupero dei dati
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // I dati sono stati recuperati correttamente
                              return Column(
                                children: [
                                Text(
                                'Matricola:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'aldrich',
                                ),
                                ),
                                  Text(
                                    userData.matriculation.split("@")[0].substring(1),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'aldrich',
                                    ),
                                  ),

                                  SizedBox(height: 20),
                                  Text(
                                  'Ruolo:',
                                  style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'aldrich',
                                  ),
                                  ),
                                  Text(
                                    userData.role,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'aldrich',
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    height: 4,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 40),
                                  Text(
                                    'Menù',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'aldrich',
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      // Le opzioni del menu sono rappresentate utilizzando i widget InkWell,
                                      // che possono essere toccati e navigano verso diverse route utilizzando
                                      // Navigator.pushNamed
                                      Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context, '/setup');
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            border: Border.all(color: Colors.white, width: 2),
                                          ),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/setup.png',
                                                width: 40,
                                                height: 40,
                                                color: Colors.white,
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                'Setups',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'aldrich',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                        onTap: () {
                                        Navigator.pushNamed(context, '/session');
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            border: Border.all(color: Colors.white, width: 2),
                                          ),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/mechanic.png',
                                                width: 40,
                                                height: 40,
                                                color: Colors.white,
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                'Sessions',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'aldrich',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            border: Border.all(color: Colors.white, width: 2),
                                          ),

                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(context, '/tracks'); // Sostituisci '/tracks' con la route corretta per la tua vista desiderata
                                                },
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/track.png',
                                                      width: 40,
                                                      height: 40,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(height: 3),
                                                    Text(
                                                      'Tracks',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 23,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'aldrich',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Nella parte inferiore dello schermo, c'è una BottomAppBar con tre icone
      // che rappresentano diverse azioni. L'icona centrale mostra un menu
      // a comparsa personalizzato rappresentato dal widget CustomPopupMenu
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Image.asset(
                'assets/images/home.png',
                width: 30,
                height: 30,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            FloatingActionButton(
              onPressed: () {

              },
              child: CustomPopupMenu(),
              backgroundColor: Colors.grey,
              elevation: 10,
            ),
            IconButton(
              icon: Image.asset(
                'assets/images/group.png',
                width: 30,
                height: 30,
              ),
              onPressed: () {
                setState(() {
                  Navigator.pushNamed(context, '/listmembers');
                });
              },

            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Image.asset(
                'assets/images/home.png',
                width: 40,
                height: 40,
              ),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/images/group.png',
                width: 40,
                height: 40,
              ),
              title: Text('Team Members'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/listmembers');
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/images/setup_black.png',
                width: 40,
                height: 40,
              ),
              title: Text('Setups'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/setup');
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/images/track_black.png',
                width: 40,
                height: 40,
              ),
              title: Text('Tracks'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/tracks');
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/images/mechanic.png',
                width: 40,
                height: 40,
              ),
              title: Text('Practice sessions'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/session');
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/images/log-out.png',
                width: 40,
                height: 40,
              ),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}

