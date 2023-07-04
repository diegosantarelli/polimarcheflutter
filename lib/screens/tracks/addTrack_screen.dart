import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTrackScreen extends StatelessWidget {
  final TextEditingController _trackNameController = TextEditingController();
  final TextEditingController _trackLengthController = TextEditingController();

  bool isAlpha(String input) {
    final alphaRegex = RegExp(r'^[a-zA-Z]+$');
    return alphaRegex.hasMatch(input);
  }

  bool isNumeric(String input) {
    final numericRegex = RegExp(r'^\d+(\.\d+)?$');
    return numericRegex.hasMatch(input);
  }

  Future<bool> isTrackNameExists(String trackName) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('track')
        .where('name', isEqualTo: trackName)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty;
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

                    // Check if track name already exists
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

                    // Create a map of track data
                    Map<String, dynamic> trackData = {
                      'name': trackName,
                      'length': trackLength,
                    };

                    // Save the track data to the "track" collection in Firebase
                    FirebaseFirestore.instance.collection('track').add(trackData);

                    // Clear the text field values after saving
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
