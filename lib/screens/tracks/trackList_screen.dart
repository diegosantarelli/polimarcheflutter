import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TracksListScreen extends StatelessWidget {
  final List<Track> trackList = [];

  void deleteTrack(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this track?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final track = trackList[index];
                FirebaseFirestore.instance.collection('track').doc(track.id).delete();
                trackList.removeAt(index); // Remove the track from the list
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //costruire un widget che ascolta le modifiche in tempo reale nel documento della collezione
    // "track" su Firebase Firestore.
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('track').snapshots(),
      builder: (context, snapshot) {
        //verifica se lo snapshot ha generato un errore
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        //Se non ci sono ancora dati disponibili, viene restituito un widget
        // CircularProgressIndicator per indicare che i dati sono in fase di caricamento.
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        //ottenuto l'elenco dei documenti presenti nella QuerySnapshot tramite snapshot.data!.docs
        final trackDocuments = snapshot.data!.docs;
        trackList.clear(); // Clear the existing list before updating it
        //vengono aggiunti gli elementi all'elenco trackList convertendo ciascun documento
        //in un oggetto Track tramite la chiamata al metodo statico fromSnapshot della classe Track.
        trackList.addAll(trackDocuments.map((doc) => Track.fromSnapshot(doc)));

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sfondo_schermata_setup.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: trackList.length,
                    itemBuilder: (context, index) {
                      final track = trackList[index];
                      return ListTile(
                        title: Row(
                          // Allinea gli elementi a destra e a sinistra
                          //Allineamento fatto rispetto all'asse principale
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              track.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${track.length} km',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                  ),
                                ),
                                SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () => deleteTrack(context, index),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          // Gestisci il clic su una traccia
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//La classe Track è un modello di dati che rappresenta un singolo elemento nella collezione
//"track" su Firebase Firestore
class Track {
  final String name;
  final String length;
  final String id;

  //Il costruttore Track viene utilizzato per creare una nuova istanza di Track
  // fornendo i valori per name, length e id.
  Track(this.name, this.length, this.id);

  //Il costruttore alternativo Track.fromSnapshot viene utilizzato per creare un'istanza
  // di Track a partire da un DocumentSnapshot, che rappresenta un singolo documento
  // nella collezione Firestore
  Track.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        length = snapshot['length'],
        id = snapshot.id;
}
