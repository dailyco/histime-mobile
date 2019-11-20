import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'login.dart';
import 'table.dart';

class CreatePage extends StatefulWidget {
  @override
  CreatePageState createState() => CreatePageState() ;
}

class CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _topbody(),
          tablebody(),
        ],
      )
    );
  }

  Widget _topbody() {
    final _logo = Column(
      children: <Widget>[
        Image.asset(
          'image/logo_small.png',
          width: 80,
          height: 20,
          fit: BoxFit.contain,
        ),
        Text(
          '이번 학기를 채울 모든 경우의 수',
          style: TextStyle(fontSize: 7),
        ),
      ],
    );

    final _top = Row(
      children: <Widget>[
        _logo,
        Expanded(
          child: SizedBox(),
        ),
        Text(
          "님, 반가워요!",
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          width: 7,
        ),
        SizedBox(
          width: 80,
          height: 25,
          child: RaisedButton(
            color: const Color(0xFFFFCA55),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(55)),
            child: Text('Logout'),
            onPressed: () {
              signOut();
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );

    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: _top
      ),
    );
  }

  Widget _buttonbody() {
    return SafeArea(
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('저 장', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            color: Color(0xFF225B95),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(55)),
            onPressed: () {},
          ),
          OutlineButton(
            child: Text('돌아가기', style: TextStyle(fontWeight: FontWeight.bold)),
            color: Colors.white,
            borderSide: BorderSide(color: Color(0xFF225B95)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(55)),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  Widget _searchbody() {
    return SlidingUpPanel(
      panel: Center(child: Text("Search Selection")),
    );
  }
}