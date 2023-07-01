import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TracksListScreen extends StatelessWidget {
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
        final trackList = trackDocuments.map((doc) => Track.fromSnapshot(doc)).toList();

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sfondo_schermata_circuiti.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder( //corrisponde alla RecyclerView in kt
                    itemCount: trackList.length,
                    itemBuilder: (context, index) {
                      final track = trackList[index];
                      return ListTile(
                        title: Row(
                          children: [
                            Text(
                              track.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(width: 100),
                            Text(
                              '${track.length} km',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                              ),
                            ),
                          ],
                        ),
                        trailing: GestureDetector(
                          onTap: () => deletetrack(index),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
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

  Track(this.name, this.length);

  Track.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        length = snapshot['length'];

}

