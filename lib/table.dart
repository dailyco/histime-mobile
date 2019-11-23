import 'package:flutter/material.dart';

Widget tablebody() {
//  return GridView.count(
//    physics: NeverScrollableScrollPhysics(),
//    shrinkWrap: true,
//    crossAxisCount: 7,
//    padding: EdgeInsets.all(16.0),
//    childAspectRatio: 8.0 / 9.0,
//    children: <Widget>[
//      TableCell(
//
//      ),
//    ],
//  );

  return Expanded(
    child: ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,

    ),
  );
}