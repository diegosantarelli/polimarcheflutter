import 'package:flutter/material.dart';

class SetupListScreen extends StatefulWidget {
  @override
  _SetupListScreenState createState() => _SetupListScreenState();
}

class _SetupListScreenState extends State<SetupListScreen> {
  final List<String> setupList = [
    'Setup 1',
    'Setup 2',
    'Setup 3',
    'Setup 4',
    'Setup 5',
    'Setup 6',
    'Setup 7',
    // Aggiungi altri setup statici se necessario
  ];

  void deleteSetup(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this setup?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Chiudi il popup
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  setupList.removeAt(index);
                });
                Navigator.of(context).pop(); // Chiudi il popup
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
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ListView.builder(
        itemCount: setupList.length,
        itemBuilder: (BuildContext context, int index) {
          final setup = setupList[index];
          return ListTile(
            title: Text(
              setup,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: GestureDetector(
              onTap: () => deleteSetup(context, index),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
