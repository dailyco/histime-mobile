import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth auth;
  final FirebaseUser user;

  HomePage({Key key, @required this.user, @required this.googleSignIn, @required this.auth}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mybody(),
    );
  }

  Widget _mybody() {
    return SafeArea(
      child: Text("Hello"),
    );
  }
}
