import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        title: Text('Sign In to Brew Crew'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 50.0,
        ),
        child: FlatButton.icon(
          onPressed: () async {
            dynamic result = await _authService.signInAnon();
            if (result == null) {
              print('Error Signing In');
            } else {
              print(result);
            }
          },
          icon: Icon(Icons.login_rounded),
          label: Text('Sign In'),
        ),
      ),
    );
  }
}
