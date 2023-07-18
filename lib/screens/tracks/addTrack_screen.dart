import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTrackScreen extends StatelessWidget {
  //oggetto di tipo TextEditingController utilizzati per gestire l'input degli utenti
  // in campi di testo.
  final TextEditingController _trackNameController = TextEditingController();
  final TextEditingController _trackLengthController = TextEditingController();

  //verifica se una stringa input contiene solo caratteri alfabetici.
  bool isAlpha(String input) {
    final alphaRegex = RegExp(r'^[a-zA-Z]+$');
    return alphaRegex.hasMatch(input);
  }

  //verifica se una stringa input contiene solo numeri.
  bool isNumeric(String input) {
    final numericRegex = RegExp(r'^\d+(\.\d+)?$');
    return numericRegex.hasMatch(input);
  }

  //verifica se il nome di una track esiste già
  Future<bool> isTrackNameExists(String trackName) async {
    //ottengo un'istanza di FirebaseFirestore, che rappresenta l'accesso al database Firestore.
    final querySnapshot = await FirebaseFirestore.instance
        .collection('track')
        .where('name', isEqualTo: trackName)
        .limit(1)
        .get();
    //restituisce una lista di oggetti QueryDocumentSnapshot
    //contenenti i documenti risultanti dalla query.
    return querySnapshot.docs.isNotEmpty;//true se non è vuota, false altrimenti.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sfondo_schermata_circuiti.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 170),
                Text(
                  'ADD TRACK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'aldrich',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _trackNameController,
                  decoration: InputDecoration(
                    hintText: 'Track name',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _trackLengthController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Track length',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Set a name different from an existing one.\nTrack length only allows decimal numbers.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'aldrich',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Perform add action and save data to Firebase
                    String trackName = _trackNameController.text;
                    String trackLength = _trackLengthController.text;

                    // Validate the input data
                    if (trackName.isEmpty ||
                        !isAlpha(trackName) ||
                        trackLength.isEmpty ||
                        !isNumeric(trackLength) ||
                        double.parse(trackLength) <= 0) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Invalid Input'),
                            content: Text(
                                'Please enter a valid track name (letters only) and track length (numeric value > 0).'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  //permette di chiudere il dialog
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    // Controlla se il nome della track esiste già
                    //await mette in pausa l'esecuzione del programma in attesa che il
                    //risultato della funzione asincrona sia disponibile.
                    bool trackNameExists = await isTrackNameExists(trackName);
                    if (trackNameExists) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Invalid Track Name'),
                            content: Text('A track with the same name already exists. Please choose a different name.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    // Crea una map
                    Map<String, dynamic> trackData = {
                      'name': trackName,
                      'length': trackLength,
                    };

                    // Salva i dati della track nella collection "track" in Firebase
                    FirebaseFirestore.instance.collection('track').add(trackData);

                    // Pulisce i valori dei Text Field dopo aver salvato
                    _trackNameController.clear();
                    _trackLengthController.clear();

                    Navigator.pop(context);
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
