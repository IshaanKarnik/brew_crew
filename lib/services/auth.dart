import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Sign in Anon
  Future signInAnon() async {
    try {
      List<FirebaseApp> apps = Firebase.apps;
      apps.forEach((app) {
        print('App name: ${app.name}');
      });
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }
  //Sign with username and pasword

  //register with username and password

  //signout
}
