import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'login.dart';

class TimeTable {
  bool isNew = false;
  int order;
  String id;
  String uid;
  String name;
  double credit;
  List<dynamic> subject;
  Map<dynamic, dynamic> subjects;

  TimeTable(String name, int order) {
    this.name = name;
    this.isNew = true;
    this.credit = 0;
    this.order = order;
    this.uid = user.uid;
    this.subject = new List(77);
    this.subjects = new Map<dynamic, dynamic>();
  }

  TimeTable.fromMap(Map<String, dynamic> map, String id)
      : assert(map['order'] != null),
        assert(map['uid'] != null),
        assert(map['name'] != null),
        assert(map['credit'] != null),
        assert(map['subject'] != null),
        assert(map['subjects'] != null),
        id = id ?? '',
        order = map['order'],
        uid = map['uid'],
        name = map['name'],
        credit = map['credit'].toDouble(),
        subject = map['subject'],
        subjects = map['subjects'];

  toJson() {
    return {
      "order": order,
      "uid": uid,
      "name": name,
      "credit": credit,
      "subject": subject,
      "subjects": subjects,
    };
  }

//  setName(String n) => name = n;

  TimeTable.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, snapshot.documentID);

//  @override
//  String toString() => "Record<$name:$votes>";
}

class CRUD{
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  CRUD( this.path ) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }
  Stream<QuerySnapshot> streamDataCollection(String uid) {
    return ref.where('uid', isEqualTo: uid).orderBy("order", descending: false).snapshots();
  }
  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }
  Future<void> removeDocument(String id){
    return ref.document(id).delete();
  }
  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }
  Future<void> updateDocument(Map data , String id) {
    return ref.document(id).updateData(data) ;
  }

}

class TTModel extends ChangeNotifier {
  CRUD crud = CRUD('table');

  List<TimeTable> tts = [];

  Future<List<TimeTable>> fetchProducts() async {
    var result = await crud.getDataCollection();
    tts = result.documents
        .map((doc) => TimeTable.fromMap(doc.data, doc.documentID))
        .toList();
    return tts;
  }

  Stream<QuerySnapshot> fetchProductsAsStream(String uid) {
    return crud.streamDataCollection(uid);
  }

  Future<TimeTable> getProductById(String id) async {
    var doc = await crud.getDocumentById(id);
    return  TimeTable.fromMap(doc.data, doc.documentID) ;
  }


  Future removeProduct(String id) async{
    await crud.removeDocument(id);
    return ;
  }

  Future updateProduct(TimeTable data,String id) async{
    await crud.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(TimeTable data) async{
    var result  = await crud.addDocument(data.toJson()) ;

    return ;

  }
}

class Subject {
  final String code, name, prof, type, time, field, location, faculty;
  final int english, credit;
  final bool like, grade, dualPF;
  final DocumentReference reference;

  Subject.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['code'] != null),
        assert(map['name'] != null),
        assert(map['prof'] != null),
        assert(map['english'] != null),
        assert(map['type'] != null),
        assert(map['time'] != null),
        assert(map['credit'] != null),
        assert(map['like'] != null),
        assert(map['grade'] != null),
        assert(map['dualPF'] != null),
        assert(map['field'] != null),
        assert(map['location'] != null),
        assert(map['faculty'] != null),
        code = map['code'],
        name = map['name'],
        prof = map['prof'],
        english = map['english'],
        type = map['type'],
        time = map['time'],
        credit = map['credit'],
        like = map['like'],
        grade = map['grade'],
        dualPF = map['dualPF'],
        field = map['field'],
        location = map['location'],
        faculty = map['faculty'];


  Subject.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$code:$name:$prof:$english:$type:$credit:$time>";
}

class SubjectsModel extends ChangeNotifier {
  CRUD crud = CRUD('subjects');

//  Stream<QuerySnapshot> fetchProductsAsStream(String uid) {
//    return crud.streamDataCollection(uid);
//  }
//
//  Future<TimeTable> getProductById(String id) async {
//    var doc = await crud.getDocumentById(id);
//    return  TimeTable.fromMap(doc.data, doc.documentID) ;
//  }
//
//
//  Future removeProduct(String id) async{
//    await crud.removeDocument(id);
//    return ;
//  }
//
//  Future updateProduct(TimeTable data,String id) async{
//    await crud.updateDocument(data.toJson(), id) ;
//    return ;
//  }
//
//  Future addProduct(TimeTable data) async{
//    var result  = await crud.addDocument(data.toJson()) ;
//
//    return ;
//
//  }
}