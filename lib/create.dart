import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'login.dart';
import 'table.dart';

class CreatePage extends StatefulWidget {
  @override
  CreatePageState createState() => CreatePageState() ;
}

class CreatePageState extends State<CreatePage> {

  final double _initFabHeight = 120.0;
  double _fabHeight;
  double _panelHeightOpen = 575.0;
  double _panelHeightClosed = 95.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
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
                _tablebody(),
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

  Widget _tablebody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Table(
        border: TableBorder.all(color: Color(0xFF225B95)),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: <TableRow>[
          ///First table row with 3 children
          TableRow(children: <Widget>[
            FittedBox(
              fit: BoxFit.contain,
              child: Container(
                margin: EdgeInsets.all(2),
                color: Colors.red,
                width: 48.0,
                height: 100.0,
                child: Center(
                  child: Text(
                    "Row 1 \n Element 1",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 6.0,
                    ),
                  ),
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Container(
                margin: EdgeInsets.all(2),
                color: Colors.orange,
                width: 50.0,
                height: 50.0,
                child: Center(
                  child: Text(
                    "Row 1 \n Element 2",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 6.0,
                    ),
                  ),
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Container(
                margin: EdgeInsets.all(2),
                color: Colors.blue,
                width: 50.0,
                height: 50.0,
                child: Center(
                  child: Text(
                    "Row 1 \n Element 3",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 6.0,
                    ),
                  ),
                ),
              ),
            ),
          ]),
          ///Second table row with 3 children
          TableRow(children: <Widget>[
            FittedBox(
              fit: BoxFit.contain,
              child: Container(
                margin: EdgeInsets.all(2),
                color: Colors.lightBlue,
                width: 50.0,
                height: 48.0,
                child: Center(
                  child: Text(
                    "Row 2 \n Element 1",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 6.0,
                    ),
                  ),
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Container(
                margin: EdgeInsets.all(2),
                color: Colors.green,
                width: 48.0,
                height: 48.0,
                child: Center(
                  child: Text(
                    "Row 2 \n Element 2",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 6.0,
                    ),
                  ),
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Container(
                margin: EdgeInsets.all(2),
                color: Colors.blue,
                width: 50.0,
                height: 100.0,
                child: Center(
                  child: Text(
                    "Row 2 \n Element 3",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 6.0,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ],
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
        SizedBox(height: 10,),
        Container(
          color: Color(0xFF225B95),
          child: SizedBox(
            height: 45,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ),
        ),
      ],
    );
  }
}