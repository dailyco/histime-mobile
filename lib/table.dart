import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

Widget tablebody() {
  return SingleChildScrollView(
    padding: EdgeInsets.all(10),
    child: Table(
      border: TableBorder.all(),
      defaultColumnWidth: FlexColumnWidth(1.0),
      columnWidths: {0: FractionColumnWidth(0.1)},
      children: <TableRow>[
        _makeDayRow(),
        _makeRow(1),
        _makeRow(2),
        _makeRow(3),
        _makeRow(4),
        _makeRow(5),
        _makeRow(6),
        _makeRow(7),
        _makeRow(8),
        _makeRow(9),
        _makeRow(10),
        _makeRow(11),
      ],
    ),
  );
}

TableRow _makeDayRow() {
  return TableRow(children: <Widget>[
    _makeDayCell(""),
    _makeDayCell("월"),
    _makeDayCell("화"),
    _makeDayCell("수"),
    _makeDayCell("목"),
    _makeDayCell("금"),
    _makeDayCell("토"),
  ]);
}

FittedBox _makeDayCell(String day) {
  return FittedBox(
    fit: BoxFit.contain,
    child: Container(
      margin: EdgeInsets.all(1),
      child: Text(day, style: TextStyle(fontSize: 1,),),
    ),
  );
}

TableRow _makeRow(int i) {
  return TableRow(children: <Widget>[
    _makeNumCell(i),
    _makeCell(),
    _makeCell(),
    _makeCell(),
    _makeCell(),
    _makeCell(),
    _makeCell(),
  ]);
}

FittedBox _makeCell() {
  return FittedBox(
    fit: BoxFit.contain,
    child: Container(
      margin: EdgeInsets.all(2),
      color: Colors.red,
    ),
  );
}

FittedBox _makeNumCell(int index) {
  return FittedBox(
    fit: BoxFit.contain,
    child: Container(
      margin: EdgeInsets.all(2),
      child: Text(index.toString(), style: TextStyle(fontSize: 3,),),
    ),
  );
}