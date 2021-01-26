import 'package:flutter/material.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Error in Firebase.initializeApp()");
          return null;
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: Wrapper(),
          );
        }
        print("Loading");
        return null;
      },
    );
  }
}
