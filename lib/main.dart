import 'package:flutter/material.dart';
import 'package:mad_histime/home.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

import 'login.dart';

void main(){
  debugPaintSizeEnabled = false;
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Histime',
      home: LoginPage(),
      routes: {
//        '/signup': (context) => SignupPage(),
//        '/search': (context) => SearchPage(),
//        '/fav_hotel': (context) => Fav_HotelPage(),
//        '/web': (context) => WebPage(),
      },
    );
  }

}

