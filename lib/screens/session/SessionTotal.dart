import 'package:flutter/material.dart';

class SessionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/sfondo_schermata_setup.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              '*You can search a practice session of a particular event by checking the check box right below and specifying the event type.\nOtherwise uncheck the checkbox below.\nThe date should be formatted like 2023-08-12 -> YYYY-MM--DD',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontFamily: 'aldrich',
              ),
            ),
            SizedBox(height: 20),
            Checkbox(
              value: false,
              onChanged: (value) {
                // Aggiungi il gestore per il cambio di stato del checkbox
              },
              visualDensity: VisualDensity.compact,
              fillColor: MaterialStateProperty.all<Color>(Colors.white),
              checkColor: Colors.black,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xBF000000),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Placeholder(), // Sostituisci con il contenuto effettivo del RecyclerView
              ),
            ),
          ],
        ),
      ),
    );
  }
}
