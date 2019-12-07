import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/rendering.dart';
import 'record.dart';
import 'timetableDB.dart';
import 'create.dart';
import 'login.dart';

final S = SubjectsModel();
final F = FavoriteModel();
double _panelHeightClosed = 30.0;

class SearchPanel extends StatefulWidget {
  TimeTable tt;
  Function callback;

  SearchPanel({Key key, @required this.tt, @required this.callback}) : super(key: key);

  @override
  _SearchPanelState createState() => _SearchPanelState(tt: tt) ;
}

class _SearchPanelState extends State<SearchPanel> {
  TimeTable tt;
  bool is_favorite = false;
  String _searchFaculty = '';
  String _searchField = '';
  String _searchType = '';
  int _searchEng = 0;
  var _searchCredit = [];
  String _searchName = '';

  _SearchPanelState({Key key, @required this.tt});

  TextEditingController searchController ;
  @override
  initState() {
    _facultyMenuItems = getFacultyItems();
    _currentFaculty = _facultyMenuItems[0].value;

    _fieldMenuItems = getFieldItems();
    _currentField = _fieldMenuItems[0].value;

    _typeMenuItems = getTypeItems();
    _currentType = _typeMenuItems[0].value;

    _englishMenuItems = getEngItems();
    _currentEng = _englishMenuItems[0].value;

    _searchCredit.clear();
    val05 = false; val1 = false; val2 = false; val3 = false;

    searchController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: searchpanel(context),
    );
  }

  Widget searchpanel(BuildContext context) {

    Stream<QuerySnapshot> streamSelect () {
      if (is_favorite)
        return F.fetchProductsAsStream(user.uid);
      else if (_currentFaculty != '전체')
        return S.fetchProductsAsStreamWithWhere('faculty', _searchFaculty);
      else if (_currentField != '전체')
        return S.fetchProductsAsStreamWithWhere('field', _searchField);
      else if (_currentType != '전체')
        return S.fetchProductsAsStreamWithWhere('type', _searchType);
      else if (_currentEng != '전체')
        return S.fetchProductsAsStreamWithWhere('english', _searchEng);
      else if (_searchCredit.isNotEmpty)
        return S.fetchProductsAsStreamWithWhere('credit', _searchCredit[0]);
      else if (searchController.text.isNotEmpty)
        return S.fetchProductsAsStreamWithWhere('name', _searchName);
      else
        return S.fetchProductsAsStream();
    }
    return Column(
      children: <Widget>[
        _panelheader(), //위에 손잡이 부분
        is_favorite ? _favoritePart(context) : _searchPart(context), //검색창 있는 부분
        StreamBuilder<QuerySnapshot>(
            stream: streamSelect(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return _subjectList(context, snapshot.data.documents);
            }),
      ],
    );
  }

  Widget _panelheader() {
    return  Container(
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
    );
  }

  Widget _searchPart(BuildContext context) {
    return Container(
      color: Color(0xFF225B95),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite),
              color: Color(0xFFFFCA55),
              onPressed: () {
                setState(() {
                  is_favorite = true ;
                });
              },
            ),
            Expanded(
              child: CupertinoTextField(
                controller: searchController,
                placeholder: "과목명 혹은 교수님명",
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFFFCA55)),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.tune),
              onPressed: () {
                filterDialog(context);
              },
              color: Color(0xFFFFCA55),
              iconSize: 25,
            ),
            Container(
              padding: EdgeInsets.only(right: 5,),
              child: SizedBox(
                width: 60,
                child: RaisedButton(
                  child: Text('검색', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      if (searchController.text.isNotEmpty) _searchName = searchController.text;
                    });
                  },
                  color: Color(0xFFFFCA55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _favoritePart(BuildContext context) {
    return Container(
      color: Color(0xFF225B95),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.storage),
              color: Color(0xFFFFCA55),
              onPressed: () {
                setState(() {
                  is_favorite = false ;
                });
              },
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              padding: EdgeInsets.only(right: 5,),
              child: SizedBox(
                width: 100,
                child: RaisedButton(
                  child: Text('모두 추가', style: TextStyle(color: Colors.white)),
                  onPressed: () {},
                  color: Color(0xFFFFCA55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _subjectList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Expanded(
        child: ListView(
          children:
          snapshot.map((data) => _subjectListItem(data)).toList(),
        )
    );
  }

  Widget _subjectListItem(DocumentSnapshot data) {
    final record = Subjects.fromSnapshot(data) ;
    S.subjects.add(record);

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF225B95), width: 2)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Text('[${record.code}] ${record.name}',
                  style: TextStyle(color: Color(0xFFFF6D00), fontWeight: FontWeight.bold),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(record.type),
                          Text(record.time),
                          Text('${record.credit}학점')
                        ],
                      ),
                    ),
                    Expanded(
                      child:  Column(
                        children: <Widget>[
                          Text(record.prof),
                          Text('영어 ${record.english}%')
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              false ? IconButton(
                icon: Icon(Icons.star),
                color: Color(0xFFFFCA55),
                onPressed: () async {
//                  record.reference.updateData({'like' : false});
                },
              )
              : IconButton(
                icon: Icon(Icons.star_border),
                color: Color(0xFFFFCA55),
                onPressed: () async {
//                  record.reference.updateData({'like' : true});
                },
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  int day = 0;
                  int period = 0;
                  List<int> subjectsIdx = [];

                  List<String> times = record.time.split(',');
                  times.forEach((e) {
                    period = int.parse(e.substring(1));
                    switch (e[0]) {
                      case '월':
                        day = 6;
                        break;
                      case '화':
                        day = 5;
                        break;
                      case '수':
                        day = 4;
                        break;
                      case '목':
                        day = 3;
                        break;
                      case '금':
                        day = 2;
                        break;
                      case '토':
                        day = 1;
                        break;
                    }
                    subjectsIdx.add(7 * period - day);
                  });

                  if (canAdd(subjectsIdx)) {
                    addSubjects(subjectsIdx, record);
                    this.widget.callback(new CreatePage(tt: tt));
                  }
                  else {
                    final snackbar = SnackBar(
                      backgroundColor: Color(0xFFFFCA55),
                      content: Text('해당 시간에 이미 과목이 존재합니다 !', textAlign: TextAlign.center,),
                    );
                    Scaffold.of(context).showSnackBar(snackbar);
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  bool canAdd(List<int> subjectsIdx) {
    bool isOk = true;

    subjectsIdx.forEach((idx) {
      if (tt.subject[idx] != null)
        isOk = false;
    });

    return isOk;
  }

  addSubjects(List<int> subjectsIdx, Subjects subject) {
    super.setState(() {
      subjectsIdx.forEach((idx) => tt.subject[idx] = subject.id);
    });
    tt.credit += subject.credit;
  }

  //dropdown menus
  List<DropdownMenuItem<String>> _facultyMenuItems;
  List<DropdownMenuItem<String>> _fieldMenuItems;
  List<DropdownMenuItem<String>> _typeMenuItems;
  List<DropdownMenuItem<String>> _englishMenuItems;
  String _currentFaculty;
  String _currentField;
  String _currentType;
  String _currentEng;
  var _currentCredit = [];

  List<DropdownMenuItem<String>> getFacultyItems() {
    List<DropdownMenuItem<String>> facultyItems = List();
    for (String _faculty in faculty) {
      facultyItems.add(new DropdownMenuItem(
          value: _faculty,
          child: Text(_faculty)
      ));
    }
    return facultyItems;
  }

  void changedFaculty(String selectedFaculty)  {
    setState(() { _currentFaculty = selectedFaculty; });
  }

  List<DropdownMenuItem<String>> getFieldItems() {
    List<DropdownMenuItem<String>> fieldItems = List();
    for (String _field in field) {
      fieldItems.add(new DropdownMenuItem(
          value: _field,
          child: Text(_field)
      ));
    }
    return fieldItems;
  }
  void changedField(String selectedField)  {
    setState(() { _currentField = selectedField; });
  }

  List<DropdownMenuItem<String>> getTypeItems() {
    List<DropdownMenuItem<String>> typeItems = List();
    for (String _type in type) {
      typeItems.add(new DropdownMenuItem(
          value: _type,
          child: Text(_type)
      ));
    }
    return typeItems;
  }

  void changedType(String selectedType)  {
    setState(() { _currentType = selectedType; });
  }

  List<DropdownMenuItem<String>> getEngItems() {
    List<DropdownMenuItem<String>> engItems = List();
    for (String _eng in english) {
      engItems.add(new DropdownMenuItem(
          value: _eng,
          child: Text(_eng)
      ));
    }
    return engItems;
  }

  void changedEng(String selectedEng)  {
    setState(() { _currentEng = selectedEng; });
  }

  bool val05 = false;
  bool val1 = false;
  bool val2 = false;
  bool val3 = false;
  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            setState(() {
              switch (title) {
                case "0.5":
                  val05 = value;
                  break;
                case "1":
                  val1 = value;
                  break;
                case "2":
                  val2 = value;
                  break;
                case "3":
                  val3 = value;
                  break;
              }
            });
            if (value) _currentCredit.add(title);
            else if (!value) _currentCredit.remove(title);
          },
        )
      ],
    );
  }

  Future<void> filterDialog(BuildContext context) async{
    return showDialog<void> (
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog (
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          backgroundColor: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF225B95), width: 3),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            height: 450,
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('학 부',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF225B95), fontWeight: FontWeight.bold)),
                    ),
                    DropdownButton<String>(
                      value: _currentFaculty,
                      items: _facultyMenuItems,
                      onChanged: changedFaculty,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('이수구분', textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF225B95), fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: DropdownButton(
                        value: _currentType,
                        items: _typeMenuItems,
                        onChanged: changedType,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('교양영역',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF225B95), fontWeight: FontWeight.bold)),
                    ),
                    DropdownButton(
                      value: _currentField,
                      items: _fieldMenuItems,
                      onChanged: changedField,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('학 점',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF225B95), fontWeight: FontWeight.bold)),
                    ),
                    checkbox("0.5", val05),
                    checkbox("1", val1),
                    checkbox("2", val2),
                    checkbox("3", val3),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('영어비율',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF225B95), fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: DropdownButton(
                        value: _currentEng,
                        items: _englishMenuItems,
                        onChanged: changedEng,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('시간대',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF225B95), fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: RaisedButton(
                        child: Text('시간대 선택', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        color: Color(0xFF225B95),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                    child: Text('검색하기', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    color: Color(0xFFFFCA55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    onPressed: () {
                      setState(() {
                        _searchFaculty = _currentFaculty;
                        _searchField = _currentField;
                        _searchType = _currentType;
                        if (_currentEng != "전체") _searchEng = int.parse(_currentEng);
                        for(int i = 0; i < _currentCredit.length; i++) {
                          _searchCredit.add(double.parse(_currentCredit[i]));
                        }
                      });
                      Navigator.pop(context) ;
//                      initState();
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

