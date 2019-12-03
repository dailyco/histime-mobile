import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'create.dart';
import 'login.dart';
import 'timetableDB.dart';

final TT = CRUDModel();

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool is_home = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mybody(),
      bottomNavigationBar: _makeBottom(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFFFCA55),
        onPressed: () => is_home? _dialog() : _dialog(),
      ),
    );
  }

  Widget _makeBottom() {
    return Container(
      height: 55.0,
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.black),
              onPressed: () {
                setState(() {
                  is_home = true;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.storage, color: Colors.black),
              onPressed: () {
                setState(() {
                  is_home = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _mybody() {
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
            },
          ),
        ),
      ],
    );

    Widget slideRightBackground() {
      return Container(
        color: Colors.green,
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.edit,
                color: Colors.white,
              ),
              Text(
                " Edit",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
        ),
      );
    }

    Widget slideLeftBackground() {
      return Container(
        color: Colors.red,
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              Text(
                " Delete",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          alignment: Alignment.centerRight,
        ),
      );
    }

    _updateLst(int idx) {
      for (int i = idx; i < TT.tts.length; i++) {
        TT.tts[i].order -= 1;
        TT.updateProduct(TT.tts[i], TT.tts[i].id);
      }
    }

    _makeListTile(int idx) {
      return Dismissible(
        key: Key(TT.tts[idx].name),
        background: slideRightBackground(),
        secondaryBackground: slideLeftBackground(),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            bool isCheck;
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  content: Text("\n'${TT.tts[idx].name}'\n시간표를 삭제하시겠습니까?",
                    textAlign: TextAlign.center,),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("취소",),
                      onPressed: () {
                        isCheck = false;
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
                        setState(() {
                          TT.removeProduct(TT.tts[idx].id);
                          _updateLst(idx);
                        });
                        isCheck = true;
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
            return isCheck;
          } else {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  content: Text("\n'${TT.tts[idx].name}'\n시간표를 수정하시겠습니까?",
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
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (contsext) => CreatePage(tt: TT.tts[idx])));
                      },
                    ),
                  ],
                );
              });
            return false;
          }
        },
        child: Container(
          margin:  EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(color: Color(0xFF9CBADF)),
          child: ListTile(
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(Icons.menu, color: Colors.white),
            ),
            title: Text(
              TT.tts[idx].name,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: <Widget>[
                Icon(Icons.flash_on, color: Color(0xFFFFCA55), size: 17),
                Text("credit : " + TT.tts[idx].credit.toString(), style: TextStyle(color: Colors.white))
              ],
            ),
            trailing: Container(
              padding: EdgeInsets.only(right: 10.0),
              child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.white, size: 25,),
                  onPressed: () {

                  }),
            ),
          ),
        ),
      );
    }



    final _homebody = Container(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: StreamBuilder(
        stream: TT.fetchProductsAsStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            TT.fetchProducts(); //<!-- TODO Async 문제 해결 -->
            return ListView.builder(
              itemCount: TT.tts.length,
              itemBuilder: (buildContext, index) =>
                  _makeListTile(index),
            );
          } else {
            return Center(
              child: Text("생성된 시간표가 없습니다.\n\n아래의 '+' 버튼을 통해 시간표를 생성해주세요.", textAlign: TextAlign.center, ),
            );
          }
        }
      ),
    );

    final _emptybox = SizedBox(
      height: 85,
    );

    final _docbody = Container(
    );

    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _top,
            Expanded(
              child: is_home? _homebody : _docbody,
            ),
            _emptybox,
          ],
        ),
      ),
    );
  }

  TextEditingController _tableNameController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _isSame(String name) {
    for(int i = 0; i < TT.tts.length; i++) {
      if (TT.tts[i].name == name) return true;
    }
    return false;
  }

  _dialog() {
    bool isWrong = false;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog (
          title: Text(
            '새로운 시간표 만들기',
            style: TextStyle(color: Color(0xFF225B95), fontWeight: FontWeight.bold),
          ),
          content: Column(
            children: <Widget>[
              SizedBox(height: 8,),
              Form(
                key: _formKey,
                child: CupertinoTextField(
                  controller: _tableNameController,
                  placeholder: "시간표의 이름을 입력하세요",
//                  decoration: BoxDecoration(color: Colors.white30),
                //<--! TODO add validator!! -->
//                  validator: (value) {
//                    if (isWrong) {
//                      return '시간표의 이름을 다시 확인해주세요';
//                    }
//                    return null;
//                  },
                ),

              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('취소'),
              onPressed: () {
                isWrong = false;
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                  '확인',
                  style: TextStyle(color: Color(0xFF225B95), fontWeight: FontWeight.bold)
              ),
              onPressed: () {
                if (_tableNameController.text == null || _isSame(_tableNameController.text)) {
                  setState(() {
                    isWrong = true;
                  });
                } else {
                  isWrong = false;
                  TimeTable newTT = TimeTable(_tableNameController.text, true);
                  _tableNameController.clear();
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (contsext) => CreatePage(tt: newTT,)));
                }
              },
            ),
          ],
        );
      },
    );
  }
}