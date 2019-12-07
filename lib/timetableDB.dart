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

class Subjects {
  final String code, name, prof, type, time, field, location, faculty, id, color;
  final int english;
  final double credit;
  final bool grade, dualPF;
  List<dynamic> uids;

  Subjects.fromMap(Map<String, dynamic> map, String id)
      : assert(map['code'] != null),
        assert(map['name'] != null),
        assert(map['prof'] != null),
        assert(map['english'] != null),
        assert(map['type'] != null),
        assert(map['time'] != null),
        assert(map['credit'] != null),
        assert(map['grade'] != null),
        assert(map['dualPF'] != null),
        assert(map['field'] != null),
        assert(map['location'] != null),
        assert(map['faculty'] != null),
        assert(map['color'] != null),
      id = id ?? '',
        code = map['code'],
        name = map['name'],
        prof = map['prof'],
        english = map['english'],
        type = map['type'],
        time = map['time'],
        credit = map['credit'].toDouble(),
        grade = map['grade'],
        dualPF = map['dualPF'],
        field = map['field'],
        location = map['location'],
        faculty = map['faculty'],
        color = map['color'],
        uids = map['uids'];

  Subjects.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, snapshot.documentID);

  toJson() {
    return {
      "uids": uids,
    };
  }
//  @override
//  String toString() => "Record<$code:$name:$prof:$english:$type:$credit:$time>";
}

class Favorite {
  String id;
  String uid;
  List<dynamic> mlkit;
  List<dynamic> subjects;

  Favorite (String name, int order) {
    this.uid = user.uid;
    this.subjects = new List<dynamic>();
    this.mlkit = new List<dynamic>();
  }

  Favorite.fromMap(Map<String, dynamic> map, String id)
      : assert(map['uid'] != null),
        id = id ?? '',
        uid = map['uid'],
        mlkit = map['mlkit'],
        subjects = map['subjects'];

  Favorite.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, snapshot.documentID);

  toJson() {
    return {
      "uid": uid,
      "mlkit": mlkit,
      "subjects": subjects,
    };
  }
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
//  Stream<QuerySnapshot> streamDataCollectionFavorite(String uid) {
//    return ref.where('uid', isEqualTo: uid).snapshots();
//  }
  Stream<QuerySnapshot> streamDataCollectionSubject() {
    return ref.snapshots();
  }
  Stream<QuerySnapshot> streamDataCollectionSubjectFavorite(String uid) {
    return ref.where('uids', arrayContains: uid).snapshots();
  }
  Stream<QuerySnapshot> streamDataCollectionSubjectWithWhere(String field, dynamic e) {
    return ref.where(field, isEqualTo: e).snapshots();
  }
  Stream<QuerySnapshot> streamDataCollectionSubjectWithWhereGreater(String field, dynamic e) {
    return ref.where(field, isGreaterThanOrEqualTo: e).snapshots();
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

  Future updateProduct(TimeTable data, String id) async{
    await crud.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(TimeTable data) async{
    var result  = await crud.addDocument(data.toJson()) ;
    return ;

  }
}

class SubjectsModel extends ChangeNotifier {
  CRUD crud = CRUD('subjects');

  List<Subjects> subjects = [];

  Future<List<Subjects>>fetchSubjects() async {
    var result = await crud.getDataCollection();
    subjects = result.documents
    .map((doc) => Subjects.fromMap(doc.data, doc.documentID))
    .toList();

    return subjects;
  }

  Future<Subjects> getProductById(String id) async {
    var doc = await crud.getDocumentById(id);
    return Subjects.fromMap(doc.data, doc.documentID);
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return crud.streamDataCollectionSubject();
  }

  Stream<QuerySnapshot> fetchProductsAsStreamFavorite(String uid) {
    return crud.streamDataCollectionSubjectFavorite(uid);
  }

  Stream<QuerySnapshot> fetchProductsAsStreamWithWhere(String filed, dynamic element) {
    return crud.streamDataCollectionSubjectWithWhere(filed, element);
  }

  Stream<QuerySnapshot> fetchProductsAsStreamWithWhereGreater(String filed, dynamic element) {
    return crud.streamDataCollectionSubjectWithWhereGreater(filed, element);
  }

  Future updateProduct(Subjects data, String id) async{
    await crud.updateDocument(data.toJson(), id) ;
    return ;
  }
}

//class FavoriteModel extends ChangeNotifier {
//  CRUD crud = CRUD('favorite');
//
//  List<Favorite> favorite = [];
//
//  Future<List<Favorite>>fetchSubjects() async {
//    var result = await crud.getDataCollection();
//    favorite = result.documents
//        .map((doc) => Favorite.fromMap(doc.data, doc.documentID))
//        .toList();
//
//    return favorite;
//  }
//
//  Stream<QuerySnapshot> fetchProductsAsStream(String uid) {
//    return crud.streamDataCollectionFavorite(uid);
//  }
//
//  Future<Favorite> getProductById(String id) async {
//    var doc = await crud.getDocumentById(id);
//    return Favorite.fromMap(doc.data, doc.documentID) ;
//  }
//}