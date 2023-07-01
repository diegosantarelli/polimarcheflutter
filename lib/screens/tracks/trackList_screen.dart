import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TracksListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sfondo_schermata_circuiti.jpg'),
              fit: BoxFit.cover,
            ),
        ),// Usa lo sfondo del tema
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Track name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: trackList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        trackList[index],
                        style: TextStyle(
                          color: Colors.white
                        ),
                    ),
                    onTap: () {
                      // Gestisci il clic su una traccia
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        // Gestisci il clic su "Add track"
                      },
                      child: Text(
                          'Add track',
                        style: TextStyle(
                          color: Colors.black
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final List<String> trackList = [
  'Track 1',
  'Track 2',
  'Track 3',
  // Aggiungi altri elementi della lista delle tracce come necessario
];