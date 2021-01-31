import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:brew_crew/models/user.dart' as UserModel;
//import 'package:flutter/foundation.dart';

class AuthService {
  final Firebase.FirebaseAuth _auth = Firebase.FirebaseAuth.instance;

  //Create User Object based on firebase user
  UserModel.User _userFromFirebase(Firebase.User user) {
    return user != null ? UserModel.User(uid: user.uid) : null;
  }

  //Auth Change User Stream
  Stream<UserModel.User> get user {
    return _auth
        .authStateChanges()
        //.map((Firebase.User user) => _userFromFirebase(user));  //Same as bellow line
        .map(_userFromFirebase); //Same as above line
  }

  //Sign in Anon
  Future signInAnon() async {
    try {
      Firebase.UserCredential result = await _auth.signInAnonymously();
      Firebase.User user = result.user;
      //if (kDebugMode) print('User : $user');
      return _userFromFirebase(user);
    } catch (e) {
      print(e);
      return null;
    }
  }
  //Sign in using email and password
  //Sign in using Gooogle
  //Sign Out
}
