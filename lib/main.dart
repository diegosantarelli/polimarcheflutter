import 'package:firebase_core/firebase_core.dart';
import 'package:polimarcheflutter/screens/home/HomeTotal_Screen.dart';
import 'package:polimarcheflutter/screens/team_members/ListMembers_screen.dart';
import 'package:polimarcheflutter/screens/session/SessionTotal.dart';
import 'package:polimarcheflutter/screens/session/addSession_screen.dart';
import 'package:polimarcheflutter/screens/setup/SetupTotal.dart';
import 'package:polimarcheflutter/screens/tracks/addTrack_screen.dart';
import 'package:polimarcheflutter/screens/tracks/track_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:polimarcheflutter/screens/login/login_screen.dart';
import 'package:polimarcheflutter/screens/signup/signup_screen.dart';


// Viene avviata l'applicazione Flutter inizializzando Firebase e avviando l'app MyApp.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

// Classe principale dell'applicazione
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Polimarche',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      initialRoute: '/login',

      // Vengono definite le routes delle diverse schermate dell'applicazione
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeTotal(),
        '/tracks': (context) => TrackScreen(),
        '/addtrack': (context) => AddTrackScreen(),
        '/setup': (context) => SetupScreen(),
        '/session': (context) => PracticeSessionScreen(),
        '/addsession': (context) => AddPracticeSessionScreen(),
        '/listmembers': (context) => MembersScreen(),
      },
    );
  }
}