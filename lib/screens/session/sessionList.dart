import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/* Questa è la schermata che visualizza un elenco di sessioni di pratica.

Ogni elemento dell'elenco viene visualizzato come un ListTile con la data della sessione.

L'utente può toccare una sessione per visualizzarne i dettagli o fare clic su un'icona per eliminarla.

Inoltre, questa schermata ha una barra di navigazione inferiore con due voci:
"Home" e "Practice Sessions
*/

class ListPracticeSessionScreen extends StatelessWidget {
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
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
          // Utilizza un StreamBuilder per ottenere i dati delle sessioni dal database Firebase.
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('practiceSessions').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    List<String> sessionDates = [];
                    List<String> sessionIds = [];
                    snapshot.data!.docs.forEach((doc) {
                      String sessionDate = doc['date'];
                      String sessionId = doc.id;
                      sessionDates.add(sessionDate);
                      sessionIds.add(sessionId);
                    });

                    return ListView.builder(
                      itemCount: sessionDates.length,
                      itemBuilder: (context, index) {
                        String sessionDate = sessionDates[index];
                        String sessionId = sessionIds[index];

                        return ListTile(

                          title: Text(
                            sessionDate,
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SessionDetailsScreen(sessionDate: sessionDate),
                              ),
                            );
                          },
                          trailing: IconButton(
                            icon: Image.asset(
                              'assets/images/bin_white.png',
                              width: 20,
                              height: 20,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Session'),
                                    content: Text('Are you sure you want to delete this session?'),
                                    actions: [
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Delete'),
                                        onPressed: () {
                                          // Elimina la sessione dal database utilizzando il sessionId
                                          FirebaseFirestore.instance.collection('practiceSessions').doc(sessionId).delete();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* Questa schermata mostra i dettagli di una sessione di pratica selezionata dall'utente
   nella schermata precedente. Riceve la data della sessione come parametro.
   Utilizza anche un StreamBuilder per ottenere i dettagli della sessione dal database Firebase
   e visualizza le informazioni come elenco di ListTile
*/

class SessionDetailsScreen extends StatelessWidget {
  final String sessionDate;

  SessionDetailsScreen({required this.sessionDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Session Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/session');
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sfondo_schermata_setup.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                'Session Date: $sessionDate',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('practiceSessions')
                      .where('date', isEqualTo: sessionDate)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      return Text('No session data available.');
                    }

                    DocumentSnapshot sessionSnapshot = snapshot.data!.docs.first;

                    String airTemperature = sessionSnapshot['airTemperature'].toString();
                    String ambientPressure = sessionSnapshot['ambientPressure'].toString();
                    String endingTime = sessionSnapshot['endingTime'];
                    String eventType = sessionSnapshot['eventType'];
                    String startingTime = sessionSnapshot['startingTime'];
                    String trackCondition = sessionSnapshot['trackCondition'];
                    String trackName = sessionSnapshot['trackName'];
                    String trackTemperature = sessionSnapshot['trackTemperature'].toString();
                    String weather = sessionSnapshot['weather'];

                    return ListView(
                      children: [
                        ListTile(
                          title: Text(
                            'Track Name: $trackName',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Starting Time: $startingTime',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Ending Time: $endingTime',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Event Type: $eventType',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Weather: $weather',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Track Condition: $trackCondition',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Air Temperature: $airTemperature',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Track Temperature: $trackTemperature',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Ambient Pressure: $ambientPressure',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
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
                  'assets/images/mechanic.png',
                  width: 20,
                  height: 20,
                ),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/session', (route) => false);
                },
              ),
              label: 'Practice Sessions',
            ),
          ],
        ),
      ),
    );
  }
}


