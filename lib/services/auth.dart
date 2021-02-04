import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:brew_crew/models/user.dart' as UserModel;
import 'package:flutter/cupertino.dart';
import 'package:brew_crew/services/database.dart';
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
      print(e.toString());
      return null;
    }
  }

  //Sign in using email and password
  Future signInWithEmailPassword(
      {@required String email, @required String password}) async {
    try {
      Firebase.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Firebase.User user = result.user;
      return user;
    } catch (e) {
      return e.toString();
    }
  }

  //Resgister using email and password
  Future registerWithEmailPassword(
      {@required String email, @required String password}) async {
    try {
      Firebase.UserCredential resut = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      Firebase.User user = resut.user;

      //create a new document for user with uid
      await DatabaseService(uid: user.uid).updateUserData(
        sugars: '0',
        name: 'new crew member',
        strength: 100,
      );
      return _userFromFirebase(user);
    } catch (e) {
      //print(e.toString());
      return e.toString();
    }
  }
  //Sign in using Gooogle

  //Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
