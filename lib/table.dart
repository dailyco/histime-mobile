import 'package:flutter/material.dart';
import 'package:mad_histime/timetableDB.dart';

import 'package:random_color/random_color.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

Widget table(TimeTable tt) {
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
            Expanded(child: _tableBody(tt),),
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

Widget _tableBody(TimeTable tt) {
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
          : Container(
              color: RandomColor().randomColor(colorHue: ColorHue.orange),
              child: Center(child: Text('Item $index'),),
            );
    },
    staggeredTileBuilder: (int index) =>
        StaggeredTile.count((index % 7) == 0? 1 : 2, 3),
  );
}