import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart' as prefix0;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';
import 'table.dart';
import 'search.dart';
import 'home.dart';
import 'timetableDB.dart';

class CreatePage extends StatefulWidget {
  TimeTable tt;

  CreatePage({Key key, @required this.tt,}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState(tt: tt) ;
}

class _CreatePageState extends State<CreatePage> {
  SearchPanel searchPanel;
  Widget currentPage;

  TimeTable tt;
  double _panelHeightOpen = 330.0;
  double _panelHeightClosed = 30.0;

  _CreatePageState({Key key, @required this.tt, });

  @override
  void initState() {
    super.initState();
    searchPanel = SearchPanel(tt: tt, callback: this.callback);

    currentPage = searchPanel;
  }

  void callback(Widget nextPage) {
    setState(() {
      this.currentPage = nextPage;
    });
  }

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
//              parallaxEnabled: true,
//              parallaxOffset: 1,
              panel: searchPanel,
//              collapsed: _panelheader(),
              body: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: <Widget>[
                    _topbody(),
                    table(tt),
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

  Widget _emptybox() {
    return SizedBox(
      height: _panelHeightClosed + 20,
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
          "${user.displayName} 님, 반가워요!",
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
            child: Text('Logout', style: TextStyle(color: Colors.white),),
            onPressed: () {
              signOut();
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
    return Column(
      children: <Widget>[
        _top,
        SizedBox(height: 10,),
      ],
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
          onPressed: () {
            if (tt.isNew)
              TT.addProduct(tt);
            else
              TT.updateProduct(tt, tt.id);
            Navigator.pop(context);
          },
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