import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:random_color/random_color.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'timetableDB.dart';
import 'create.dart';

Widget table(BuildContext context, TimeTable tt, Function callback) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF225B95)),
        ),
        child: Column(
          children: <Widget>[
            _tableTitle(tt),
            _tableDay(),
            Expanded(child: _tableBody(context, tt, callback),),
            _tableBottom(tt),
          ],
        ),
      ),
    ),
  );
}

Widget _tableTitle(TimeTable tt) {
  return Container(
    color: Color(0xFF225B95),
    child: Row(
      children: <Widget>[
        SizedBox(width: 10,),
        Expanded(
          child: Text(tt.name, style: TextStyle(color: Colors.white, fontSize: 17),),
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

Widget _tableDay() {
  List<String> _dayLst = ["", "월", "화", "수", "목", "금", "토"];

  return Container(
    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFF225B95)),),
    ),
    child: Row(
      children: _dayLst.map((d) => _day(d)).toList(),
    ),
  );
}

Widget _day(String day) {
  return Expanded(
    flex: day == ""? 1 : 2,
    child: Text(day, textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),
  );
}

Widget _tableBody(BuildContext context, TimeTable tt, Function callback) {
  return StaggeredGridView.countBuilder(
    shrinkWrap: true,
    crossAxisCount: 13,
    itemCount: 77,
    itemBuilder: (BuildContext context, int index) {
      return (index % 7) == 0
          ? Container(
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Color(0xFF225B95)), /*bottom: BorderSide(color: Color(0xFF225B95)),*/),
              ),
              child: Center(child: Text(((index / 7) + 1).toInt().toString(), style: TextStyle(fontSize: 15,),),
              ),
            )
          : tt.subject[index] == null
          ? null
          : _makeTimeSubject(context, tt, index, callback);
    },
    staggeredTileBuilder: (int index) =>
        StaggeredTile.count((index % 7) == 0? 1 : 2, 3),
  );
}

Widget _makeTimeSubject(BuildContext context, TimeTable tt, int idx, Function callback) {
  return GestureDetector(
    child: Container(
      color: RandomColor().randomColor(colorHue: ColorHue.orange),
      child: Center(child: Text(tt.subject[idx]),),
    ),
    onLongPress: () => _checkDelete(context, tt, idx, callback),
  );
}

Widget _tableBottom(TimeTable tt) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
    color: Color(0xFF225B95),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text("Total credit: " + tt.credit.toString(), style: TextStyle(color: Colors.white, ), textAlign: TextAlign.right,),
        ),
        SizedBox(width: 10,),
      ],
    ),
  );
}

_checkDelete(BuildContext context, TimeTable tt, int idx, Function callback) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        content: Text("'${tt.subject[idx]}'을 삭제하시겠습니까?",
          textAlign: TextAlign.center,),
        actions: <Widget>[
          FlatButton(
            child: Text("취소",),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text(
              "확인",
              style: TextStyle(color: Color(0xFF225B95),
                fontWeight: FontWeight.bold,),
            ),
            onPressed: () {
              _deletesubjects(tt, idx);
              callback(new CreatePage(tt: tt));
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

_deletesubjects(TimeTable tt, int idx) {
  String id = tt.subject[idx];

  for (int i = 0; i < tt.subject.length; i++) {
    if (tt.subject[i] == id)
      tt.subject[i] = null;
  }

  // TODO 전제척으로 subject id로 작업하는걸로 바꾸고 그에 맞게 credit도 수정
  tt.credit -= 0;
}