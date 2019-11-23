import 'package:flutter/material.dart';

Future<void> filterDialog(BuildContext context) async {

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        backgroundColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF225B95), width: 3),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          height: 500,
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('학부',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF225B95), fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: FlatButton(child: Text("선택"), onPressed: (){},),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('이수구분', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: FlatButton(child: Text("선택"), onPressed: (){},),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}