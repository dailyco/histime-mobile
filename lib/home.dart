import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mad_histime/createTable.dart';

class HomePage extends StatefulWidget {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth auth;
  final FirebaseUser user;

  HomePage({Key key, @required this.user, @required this.googleSignIn, @required this.auth}) : super(key: key);

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
        onPressed: () => _dialog(),
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
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );

    final makeListTile = ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.autorenew, color: Colors.white),
        ),
        title: Text(
          "Introduction to Driving",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text(" Intermediate", style: TextStyle(color: Colors.white))
          ],
        ),
        trailing:
        Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));

    final makeCard = Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile,
      ),
    );

    final _homebody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return makeCard;
        },
      ),
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
            is_home? _homebody : _docbody,
          ],
        ),
      ),
    );
  }

  TextEditingController tableNameController ;
  @override
  initState() {
    tableNameController = TextEditingController() ;
    super.initState() ;
  }

  void _dialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog (
          title: Text(
            '시간표 만들기',
            style: TextStyle(color: Color(0xFF225B95), fontWeight: FontWeight.bold),
          ),
          content: Card(
            color: Colors.transparent,
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: tableNameController,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: '새로운 시간표의 이름을 입력하세요',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('취소'),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text(
                  '확인',
                  style: TextStyle(color: Color(0xFF225B95), fontWeight: FontWeight.bold)
              ),
              onPressed: () {
                //시간표 이름 리스트에 추가
                //만들기 창으로 이동
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTablePage())) ;
              },
            ),
          ],
        );
      },
    );
  }
}
