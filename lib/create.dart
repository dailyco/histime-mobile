import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart' as prefix0;

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
  double _panelHeightClosed = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            prefix0.SlidingUpPanel(
              maxHeight: _panelHeightOpen,
              minHeight: _panelHeightClosed,
              parallaxEnabled: true,
              panel: _searchpanel(),
              collapsed: Container(
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
              ),
              body: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: <Widget>[
                    _topbody(),
                    tablebody(),
                    _buttonbody(),
                  ],
                ),
              ),
            ),
          ],
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
      children: <Widget>[
        Container(
          color: Color(0xFF225B95),
          child: SizedBox(
            height: 45,
            child: Container(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite),
                    color: Color(0xFFFFCA55),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 180,
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
                  SizedBox(width: 10),
                  SizedBox(
                    width: 60,
                    height: 30,
                    child: RaisedButton(
                      child: Text('검색'),
                      onPressed: () {},
                      color: Color(0xFFFFCA55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  SizedBox(width: 7),
                  SizedBox(
                    width: 60,
                    height: 30,
                    child: RaisedButton(
                      child: Text('필터'),
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
      ],
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