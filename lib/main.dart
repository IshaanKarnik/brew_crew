import 'package:brew_crew/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/screens/wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: Wrapper(),
    // );
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Failed to initialize firebase');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: Wrapper(),
          );
        }
        print('Initializing Flutter');
      },
    );
  }
}
