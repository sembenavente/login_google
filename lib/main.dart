import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (err) {
      print(err);
    }
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _isLoggedIn
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_googleSignIn.currentUser.displayName),
                    Text(_googleSignIn.currentUser.email),
                    OutlineButton(
                      child: Text("logout"),
                      onPressed: () {
                        _logout();
                      },
                    )
                  ],
                )
              : OutlineButton(
                  child: Text("login with Google"),
                  onPressed: () {
                    _login();
                  },
                ),
        ),
      ),
    );
  }
}
