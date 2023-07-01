import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TracksListScreen extends StatelessWidget {
  final List<Track> trackList = [];

  void deleteTrack(int index) {
    final track = trackList[index];
    FirebaseFirestore.instance.collection('track').doc(track.id).delete();
    trackList.removeAt(index); // Remove the track from the list
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('track').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        final trackDocuments = snapshot.data!.docs;
        trackList.clear(); // Clear the existing list before updating it
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Allinea gli elementi a destra e a sinistra
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
                                  onTap: () => deleteTrack(index),
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

class Track {
  final String name;
  final String length;
  final String id;

  Track(this.name, this.length, this.id);

  Track.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        length = snapshot['length'],
        id = snapshot.id;
}
