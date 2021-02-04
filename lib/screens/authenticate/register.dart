import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toogleView;
  Register({this.toogleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String conformPassword = '';
  String error = '';
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              title: Text('Register to brew crew'),
              //centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.brown[400],
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    widget.toogleView();
                  },
                  icon: Icon(Icons.login_rounded),
                  label: Text('Sign-In'),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 50.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'Enter Email' : null,
                      //On success validator should return null
                      decoration: textInputDecoration.copyWith(
                        hintText: 'E-Mail',
                        labelText: 'E-Mail',
                      ),
                      onChanged: (value) {
                        setState(() => email = value);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (value) => value.length < 6
                          ? 'Password should be at least 6 character long'
                          : null,
                      //On success validator should return null
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Password',
                        labelText: 'Password',
                      ),
                      onChanged: (value) {
                        setState(() => password = value);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => _loading = true);
                          dynamic result =
                              await _auth.registerWithEmailPassword(
                                  email: email, password: password);
                          if (result is String) {
                            setState(() {
                              error = result;
                              _loading = false;
                            });
                          }
                          // print(
                          //     'Register Email : $email\nRegister Password : $password');
                        }
                      },
                      textColor: Colors.white,
                      color: Colors.indigo,
                      child: Text('Register'),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
