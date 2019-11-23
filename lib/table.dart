import 'package:flutter/material.dart';

Widget tablebody() {
  return Expanded(
    child: Row(
//      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(6, (d) => _buildColumn(d)).toList(),
    ),
  );

//  return Expanded(
//    child: ListView(
//      scrollDirection: Axis.vertical,
//      shrinkWrap: true,
//      children: <Widget>[
//
//      ],
//    ),
//  );
}

Widget _buildColumn(int d) {
  return Positioned(
//    left: 0.0,
//    top: d * 25.0,
//    right: 0.0,
//    height: 50.0 * (d + 1),
//    child: Container(
//      margin: EdgeInsets.symmetric(horizontal: 2.0),
//      color: Colors.orange[100 + d * 100],
//    ),
  );
}