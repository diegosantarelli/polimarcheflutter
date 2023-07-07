import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPracticeSessionScreen extends StatelessWidget {
  final TextEditingController _airTemperatureController = TextEditingController();
  final TextEditingController _ambientPressureController = TextEditingController();
  final TextEditingController _sessionDateController = TextEditingController();
  final TextEditingController _endingTimeController = TextEditingController();
  final TextEditingController _startingTimeController = TextEditingController();
  final TextEditingController _trackConditionController = TextEditingController();
  final TextEditingController _trackNameController = TextEditingController();
  final TextEditingController _trackTemperatureController = TextEditingController();
  final TextEditingController _weatherController = TextEditingController();
  final TextEditingController _eventTypeController = TextEditingController();

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
        color: Colors.black,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sfondo_schermata_circuiti.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'ADD PRACTICE SESSION',
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
                    controller: _airTemperatureController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Air temperature',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _ambientPressureController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      hintText: 'Ambient pressure',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _sessionDateController,
                    decoration: InputDecoration(
                      hintText: 'Session date (yyyy-mm-dd)',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _startingTimeController,
                    decoration: InputDecoration(
                      hintText: 'Starting time (HH:MM:SS)',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _endingTimeController,
                    decoration: InputDecoration(
                      hintText: 'Ending time (HH:MM:SS)',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _trackConditionController,
                    decoration: InputDecoration(
                      hintText: 'Track condition',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
                    controller: _trackTemperatureController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Track temperature',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _weatherController,
                    decoration: InputDecoration(
                      hintText: 'Weather',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _eventTypeController,
                    decoration: InputDecoration(
                      hintText: 'Event type',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // Perform add action and save data to Firebase
                      String airTemperature = _airTemperatureController.text;
                      String ambientPressure = _ambientPressureController.text;
                      String sessionDate = _sessionDateController.text;
                      String endingTime = _endingTimeController.text;
                      String startingTime = _startingTimeController.text;
                      String trackCondition = _trackConditionController.text;
                      String trackName = _trackNameController.text;
                      String trackTemperature = _trackTemperatureController.text;
                      String weather = _weatherController.text;
                      String eventType = _eventTypeController.text;

                      // Validate the input data
                      if (airTemperature.isEmpty ||
                          ambientPressure.isEmpty ||
                          sessionDate.isEmpty ||
                          endingTime.isEmpty ||
                          startingTime.isEmpty ||
                          trackCondition.isEmpty ||
                          trackName.isEmpty ||
                          trackTemperature.isEmpty ||
                          weather.isEmpty ||
                          eventType.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Invalid Input'),
                              content: Text('Please enter all the required fields.'),
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

                      // Validate the format of ending time and starting time
                      final timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d):([0-5]\d)$');
                      if (!timeRegex.hasMatch(endingTime) || !timeRegex.hasMatch(startingTime)) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Invalid Time Format'),
                              content: Text('Please enter ending time and starting time in the format HH:MM:SS.'),
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

                      // Validate that ending time is later than starting time
                      final startTime = DateTime.parse('2000-01-01 $startingTime');
                      final endTime = DateTime.parse('2000-01-01 $endingTime');
                      if (endTime.isBefore(startTime)) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Invalid Time Range'),
                              content: Text('Ending time must be later than starting time.'),
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

                      // Validate the format of session date
                      final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                      if (!dateRegex.hasMatch(sessionDate)) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Invalid Date Format'),
                              content: Text('Please enter session date in the format yyyy-mm-dd.'),
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

                      // Validate that session date is later than today's date
                      final currentDate = DateTime.now().toLocal().toString().split(' ')[0];
                      final enteredDate = sessionDate.split('-').join('-');
                      if (enteredDate.compareTo(currentDate) <= 0) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Invalid Session Date'),
                              content: Text('Session date must be later than today.'),
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

                      // Verifica se il nome della track esiste nel database
                      final trackNameExists = await FirebaseFirestore.instance
                          .collection('track')
                          .where('name', isEqualTo: trackName)
                          .get();

                      if (trackNameExists.docs.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Invalid Track Name'),
                              content: Text('The entered track name does not exist.'),
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

                      // Create a map of session data
                      Map<String, dynamic> sessionData = {
                        'airTemperature': int.parse(airTemperature),
                        'ambientPressure': double.parse(ambientPressure),
                        'date': sessionDate,
                        'endingTime': endingTime,
                        'startingTime': startingTime,
                        'trackCondition': trackCondition,
                        'trackName': trackName,
                        'trackTemperature': int.parse(trackTemperature),
                        'weather': weather,
                        'eventType': eventType,
                      };

                      // Save the session data to the "practiceSessions" collection in Firebase
                      FirebaseFirestore.instance.collection('practiceSessions').add(sessionData);

                      // Clear the text field values after saving
                      _airTemperatureController.clear();
                      _ambientPressureController.clear();
                      _sessionDateController.clear();
                      _endingTimeController.clear();
                      _startingTimeController.clear();
                      _trackConditionController.clear();
                      _trackNameController.clear();
                      _trackTemperatureController.clear();
                      _weatherController.clear();
                      _eventTypeController.clear();

                      Navigator.pop(context);
                    },
                    child: Text('Add'),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
