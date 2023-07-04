import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MembersScreen extends StatefulWidget {
  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Team Members',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontFamily: 'aldrich',
            ),
          ),
          centerTitle: true, // Centra il titolo nell'appBar
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sfondo_schermata_home.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('team_members')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              return ListView.separated(
                itemCount: snapshot.data!.docs.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final document = snapshot.data!.docs[index];
                  final data = document.data() as Map<String, dynamic>;
                  final firstName = data['firstName'];
                  final matriculation = data['matriculation'];
                  final workshopArea = data['workshopArea'];
                  final lastName = data['lastName'];
                  final itemNumber = index + 1; // Aggiunto il numero dell'elemento

                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Membro $itemNumber', // Visualizza il numero dell'elemento
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Matricola: $matriculation',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        Text(
                          'Nome: $firstName',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        Text(
                          'Cognome: $lastName',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        Text(
                          'Area di competenza: $workshopArea',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ],
                    ),
                  );
                },
              );

            },
          ),
        ),
      ),
    );
  }
}
