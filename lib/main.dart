import 'dart:io';

import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

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
          return MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.brown[100],
              appBar: AppBar(
                backgroundColor: Colors.brown[400],
                title: Text('Error Loading Brew Crew'),
                centerTitle: true,
              ),
              body: Center(
                  child: AlertDialog(
                title: Text('Error Loading Brew Crew'),
                content: Text(snapshot.error.toString()),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => exit(0),
                    child: Text('OK'),
                  ),
                ],
              )),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<User>.value(
            value: AuthService().user,
            child: MaterialApp(
              home: Wrapper(),
            ),
          );
        }
        print('Initializing Flutter');
        return MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: Text('Loading Brew Crew'),
              centerTitle: true,
            ),
            body: SpinKitFadingCircle(
              color: Colors.brown,
              size: 50.0,
            ),
          ),
        );
      },
    );
  }
}
//Bellow is the ideal implementation but causes problem in setting and register page
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.brown[100],
//         appBar: AppBar(
//           backgroundColor: Colors.brown[400],
//           title: Text('Brew Crew'),
//           centerTitle: true,
//         ),
//         body: FutureBuilder(
//             future: _initialization,
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Center(
//                   child: AlertDialog(
//                     title: Text('Error Loading Brew Crew'),
//                     content: Text(snapshot.error.toString()),
//                     actions: <Widget>[
//                       FlatButton(
//                         onPressed: () => exit(0),
//                         child: Text('OK'),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return StreamProvider<User>.value(
//                   value: AuthService().user,
//                   child: Wrapper(),
//                 );
//               }
//               print('Initializing Flutter');
//               return Center(
//                 child: SpinKitFadingCircle(
//                   color: Colors.brown,
//                   size: 50.0,
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }
