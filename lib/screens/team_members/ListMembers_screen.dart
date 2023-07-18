import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//La classe _MembersScreenState sarà responsabile di gestire lo stato associato a MembersScreen
//e di aggiornare l'interfaccia utente in base a tali modifiche.
class MembersScreen extends StatefulWidget {
  @override
  //crea e restituisce un'istanza di _MembersScreenState, che rappresenta lo stato associato
  // a MembersScreen.
  // Il prefisso _ prima di _MembersScreenState indica che la classe _MembersScreenState
  // è considerata privata e può essere utilizzata solo all'interno del file in cui è definita.
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  @override
  Widget build(BuildContext context) {
    //WillPopScope, che consente di gestire l'evento di pressione del pulsante di "back"
    //o di navigazione all'indietro nel dispositivo o nella barra di navigazione.
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        //restituito il valore booleano false per indicare che l'evento di pressione
        //del pulsante di "back" non deve essere gestito ulteriormente
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
          // Utilizza il widget StreamBuilder per ascoltare le modifiche in uno stream di dati
          // proveniente da Firestore.
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
                //viene utilizzato per specificare il numero di elementi da visualizzare
                // o elaborare nell'interfaccia utente in base al numero di documenti presenti
                // nello snapshot dei dati di Firestore ricevuti dallo stream.
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
