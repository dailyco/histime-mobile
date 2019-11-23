import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';
import 'table.dart';

final dummySubjects = [
  {"code": "ECE20010-01",
    "name": "데이터 구조",
    "prof": "김영섭",
    "english": 20,
    "type": "전선",
    "time": "월1, 월2, 목1, 목2",
    "credit": 3,
  },
  {"code": "ECE20010-02",
    "name": "김유진바보",
    "prof": "메롱",
    "english": 21,
    "type": "멍청이",
    "time": "오롤롤",
    "credit": 4,
  },
];

class CreatePage extends StatefulWidget {
  @override
  CreatePageState createState() => CreatePageState() ;
}

class CreatePageState extends State<CreatePage> {

  double _panelHeightOpen = 575.0;
  double _panelHeightClosed = 95.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .3,
            body: Column(
              children: <Widget>[
                _topbody(),
                tablebody(),
                _buttonbody()
              ],
            ),
            panel: _searchpanel(),
          ),
        ],
      ),
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
    return ButtonBar(
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
    );
  }

  TextEditingController searchController ;

  Widget _searchpanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Color(0xFF225B95),
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          color: Color(0xFF225B95),
          child: SizedBox(
            height: 40,
            child: Container(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite),
                    color: Color(0xFFFFCA55),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 200,
                    height: 30,
                    child: CupertinoTextField(
                      controller: searchController,
                      placeholder: "과목명 혹은 교수님명",
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFFFCA55)),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    icon: Icon(Icons.tune),
                    onPressed: () {},
                    color: Color(0xFFFFCA55),
                    iconSize: 25,
                  ),
                  SizedBox(
                    width: 60,
                    height: 30,
                    child: RaisedButton(
                      child: Text('검색', style: TextStyle(color: Colors.white)),
                      onPressed: () {},
                      color: Color(0xFFFFCA55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
        SizedBox(
//          child: _subjectList(context, dummySubjects),
        ),
      ],
    );
  }
  Widget _subjectList(BuildContext context, List<Map> snapshot) {
    return ListView(
      children: snapshot.map((data) => _subjectListItem(context, data)).toList(),
    );
  }

  Widget _subjectListItem(BuildContext context, Map data) {
    final record = Record.fromMap(data) ;
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: ListTile(
        title: Text(record.name),
      ),
    );
  }
}
class Record {
  final String code, name, prof, type, time ;
  final int english, credit;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['code'] != null),
        assert(map['name'] != null),
        assert(map['prof'] != null),
        assert(map['english'] != null),
        assert(map['type'] != null),
        assert(map['time'] != null),
        assert(map['credit'] != null),
        code = map['code'],
        name = map['name'],
        prof = map['prof'],
        english = map['english'],
        type = map['type'],
        time = map['time'],
        credit = map['credit'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$code:$name:$prof:$english:$type:$credit:$time>";
}