import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart' as prefix0;
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
  double _panelHeightOpen = 330.0;
  double _panelHeightClosed = 30.0;
  double _oneTimeHeight = 50.0;
  double _width;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            prefix0.SlidingUpPanel(
              maxHeight: _panelHeightOpen,
              minHeight: _panelHeightClosed,
//              parallaxEnabled: true,
//              parallaxOffset: 1,
              panel: _searchpanel(),
//              collapsed: _panelheader(),
              body: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: <Widget>[
                    _topbody(),
                    _table(),
                    _buttonbody(),
                    _emptybox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _table() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF225B95)),
          ),
          child: Column(
            children: <Widget>[
              _tableTitle(),
              _tableDay(),
              _tableBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableBody() {
    return Container(
      child: Row(
        children: <Widget>[
          _tableTime(),
//        tablebody(),
        ],
      ),
    );
  }

  Widget _tableTime() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Color(0xFF225B95)),),
      ),
      child: Column(
        children: <Widget>[
          _time("1"),
          _time("2"),
          _time("3"),
          _time("4"),
          _time("5"),
          _time("6"),
          _time("7"),
          _time("8"),
          _time("9"),
          _time("10"),
          _time("11"),
        ],
      ),
    );
  }

  Widget _time(String time) {
    return SizedBox(
      width: (_width - 20) / 13,
      height: _oneTimeHeight,
      child: Center(
        child: Text(time, style: TextStyle(fontSize: 15,),),
      )
    );
  }

  Widget _tableDay() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF225B95)),),
      ),
      child: Row(
        children: <Widget>[
          _day(""),
          _day("월"),
          _day("화"),
          _day("수"),
          _day("목"),
          _day("금"),
          _day("토"),
        ],
      ),
    );
  }

  Widget _day(String day) {
    return Expanded(
      flex: day == ""? 1 : 2,
      child: Text(day, textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),
    );
  }

  Widget _tableTitle() {
    return Container(
      color: Color(0xFF225B95),
      child: Row(
        children: <Widget>[
          SizedBox(width: 10,),
          Expanded(
            child: Text("예비 시간표1", style: TextStyle(color: Colors.white, fontSize: 17),),
          ),
          IconButton(
            icon: Icon(Icons.view_list),
            color: Color(0xFFFFCA55),
            iconSize: 25,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            color: Color(0xFFFFCA55),
            iconSize: 25,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _emptybox() {
    return SizedBox(
      height: _panelHeightClosed + 20,
    );
  }

  Widget _panelheader() {
    return  Container(
      decoration: BoxDecoration(
        color: Color(0xFF225B95),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      width: 100,
      height: _panelHeightClosed,
      child: Center(
        child: Text(
          "Search",
          style: TextStyle(color: Colors.white),
        ),
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

    return _top;
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
          child: Text('돌아가기', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF225B95))),
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
      children: <Widget>[
        _panelheader(),
        Container(
          color: Color(0xFF225B95),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 2, 5, 2),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite),
                  color: Color(0xFFFFCA55),
                  onPressed: () {},
                ),
                Expanded(
                  child: CupertinoTextField(
                    controller: searchController,
                    placeholder: "과목명 혹은 교수님명",
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFFFCA55),),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.tune),
                  onPressed: () {},
                  color: Color(0xFFFFCA55),
                  iconSize: 25,
                ),
                SizedBox(
                  width: 70,
                  child: RaisedButton(
                    color: Color(0xFFFFCA55),
                    child: Text('검색', style: TextStyle(color: Colors.white)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: _subjectList(context, dummySubjects),
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

class TableHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Color(0xFF225B95),
      child: Center(
        child: Text('Name'),
      ),
    );
  }

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
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