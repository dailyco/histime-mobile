import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mad_histime/create.dart';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';

import 'login.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool is_home = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mybody(),
      bottomNavigationBar: _makeBottom(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFFFCA55),
        onPressed: () => is_home? _dialog() : _dialog(),
      ),
    );
  }

  Widget _makeBottom() {
    return Container(
      height: 55.0,
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.black),
              onPressed: () {
                setState(() {
                  is_home = true;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.storage, color: Colors.black),
              onPressed: () {
                setState(() {
                  is_home = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _mybody() {
    final _names = <String>["예비 시간표", "예비1", "예비2", "예비3", "예비4", "예비5", "예비6"];

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
            child: Text('Logout', style: TextStyle(color: Colors.white),),
            onPressed: () {
              signOut();
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );

    _makeListTile(String name) {
      return Container(
        margin:  EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(color: Color(0xFF9CBADF)),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.menu, color: Colors.white),
          ),
          title: Text(
            name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Icon(Icons.flash_on, color: Color(0xFFFFCA55), size: 17),
              Text("credit : 18", style: TextStyle(color: Colors.white))
            ],
          ),
          trailing: Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
                icon: Icon(Icons.edit, color: Colors.white, size: 25,),
                onPressed: () {

                }),
            ),
          ),
        );
      }

      final _homebody = Container(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: ListView(
          shrinkWrap: true,
          addAutomaticKeepAlives: false,
          children: _names.map((name) {
            return _makeListTile(name);
          }).toList(),
        ),
      );

      final _emptybox = SizedBox(
        height: 85,
      );

      final _docbody = Container(
      );

      return SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _top,
              Expanded(
                child: is_home? _homebody : _docbody,
              ),
              _emptybox,
            ],
          ),
        ),
      );
    }

  TextEditingController tableNameController ;

  _dialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog (
          title: Text(
            '새로운 시간표 만들기',
            style: TextStyle(color: Color(0xFF225B95), fontWeight: FontWeight.bold),
          ),
          content: Card(
            color: Colors.transparent,
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                SizedBox(height: 8,),
                CupertinoTextField(
                  controller: tableNameController,
                  placeholder: "시간표의 이름을 입력하세요",
                  decoration: BoxDecoration(color: Colors.white30)
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                  '확인',
                  style: TextStyle(color: Color(0xFF225B95), fontWeight: FontWeight.bold)
              ),
              onPressed: () {
                Navigator.pop(context) ;
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage())) ;
              },
            ),
          ],
        );
      },
    );
  }
}
