import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class TimeTable {
  final int order;
  final String id;
  final String uid;
  final String name;
  final double credit;
  final Map<dynamic, dynamic> subjects;
//  final DocumentReference reference;

  TimeTable.fromMap(Map<String, dynamic> map, String id)
      : assert(map['order'] != null),
        assert(map['uid'] != null),
        assert(map['name'] != null),
        assert(map['credit'] != null),
        assert(map['subjects'] != null),
        id = id,
        order = map['order'],
        uid = map['uid'],
        name = map['name'],
        credit = map['credit'].toDouble(),
        subjects = map['subjects'];

  toJson() {
    return {
      "order": order,
      "uid": uid,
      "name": name,
      "credit": credit,
      "subjects": subjects,
    };
  }

//  TimeTable.fromSnapshot(DocumentSnapshot snapshot)
//      : this.fromMap(snapshot.data, reference: snapshot.reference);

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
    return ref.getDocuments() ;
  }
  Stream<QuerySnapshot> streamDataCollection() {
    return ref.orderBy("order", descending: false).snapshots() ;
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

class CRUDModel extends ChangeNotifier {
  CRUD crud = CRUD('table');

  List<TimeTable> tts;

  Future<List<TimeTable>> fetchProducts() async {
    var result = await crud.getDataCollection();
    tts = result.documents
        .map((doc) => TimeTable.fromMap(doc.data, doc.documentID))
        .toList();
    return tts;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return crud.streamDataCollection();
  }

  Future<TimeTable> getProductById(String id) async {
    var doc = await crud.getDocumentById(id);
    return  TimeTable.fromMap(doc.data, doc.documentID) ;
  }


  Future removeProduct(String id) async{
    await crud.removeDocument(id) ;
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