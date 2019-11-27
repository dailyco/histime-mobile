import 'package:flutter/material.dart';

import 'package:random_color/random_color.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

Widget tableBody() {
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
          : Container(
              color: RandomColor().randomColor(colorHue: ColorHue.orange),
              child: Center(child: Text('Item $index'),),
            );
    },
    staggeredTileBuilder: (int index) =>
        StaggeredTile.count((index % 7) == 0? 1 : 2, 3),
  );
}