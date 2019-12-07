import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mad_histime/home.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

FirebaseUser user;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mybody(),
    );
  }

  Widget _mybody() {
    final _title = Center(
        child: Column(
          children: <Widget>[
            Image.asset(
              'image/logo_large.png',
              width: 300,
              height: 100,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 5,),
            Text('이번 학기를 채울 모든 경우의 수, HisTime'),
          ],
        ),
    );

    final _histimeLogin = Container(
      padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50.0),
          TextField(
            controller: _idController,
            decoration: InputDecoration(
              filled: true,
              hintText: 'HisTime ID',
              fillColor: Colors.white,
            ),
          ),
          SizedBox(height: 12.0),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              filled: true,
              hintText: 'HisTime Password',
              fillColor: Colors.white,
            ),
            obscureText: true,
          ),
          SizedBox(height: 24.0),
          RaisedButton(
            color: const Color(0xFFFFCA55),
            child: Text('Login'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)
                    => HomePage()));
            },
          ),
        ],
      ),
    ) ;

    final _otherLogin = Column(
      children: <Widget>[
        SignInButton(
          Buttons.Google,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          onPressed: () async {
            _signInWithGoogle().then((s) {
              print(s);
              if (_success) {
                Navigator.push(context, MaterialPageRoute(builder: (context)
                      => HomePage()));
              }
            });
          },
        ),
        SignInButtonBuilder(
          text: "Sign in with Anonymous",
          icon: Icons.person_pin,
          backgroundColor: Colors.blueGrey[500],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          onPressed: () async {
            _signInAnonymously().then((s) {
              print(s);
              if (_success) {
                Navigator.push(context, MaterialPageRoute(builder: (context)
                      => HomePage()));
              }
            });
          },
        ),
      ],
    ) ;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 120, 0, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _title,
//            _histimeLogin,
            SizedBox(height: 70),
            _otherLogin,
          ],
        ),
      ),
    );
  }

  Future<String> _signInAnonymously() async {
    final FirebaseUser _user = (await _auth.signInAnonymously()).user;
    assert(_user != null);
    assert(_user.isAnonymous);
    assert(!_user.isEmailVerified);
    assert(await _user.getIdToken() != null);
    if (Platform.isIOS) {
      // Anonymous auth doesn't show up as a provider on iOS
      assert(_user.providerData.isEmpty);
    } else if (Platform.isAndroid) {
      // Anonymous auth does show up as a provider on Android
      assert(_user.providerData.length == 1);
      assert(_user.providerData[0].providerId == 'firebase');
      assert(_user.providerData[0].uid != null);
      assert(_user.providerData[0].displayName == null);
      assert(_user.providerData[0].photoUrl == null);
      assert(_user.providerData[0].email == null);
    }

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(_user.uid == currentUser.uid);
    setState(() {
      if (_user != null) {
        _success = true;
        user = _user;
      } else {
        _success = false;
      }
    });

    return 'signInAnonymously succeeded: $_user';
  }

  Future<String> _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser _user =
        (await _auth.signInWithCredential(credential)).user;
    assert(_user.email != null);
    assert(_user.displayName != null);
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(_user.uid == currentUser.uid);

    setState(() {
      if (_user != null) {
        _success = true;
        user = _user;
      } else {
        _success = false;
      }
    });

    return 'signInWithGoogle succeeded: $_user';
  }
}

signOut() async {
  await _googleSignIn.signOut();
  await _auth.signOut();
}