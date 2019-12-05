import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String code, name, prof, type, time, field, location, faculty;
  final int english, credit;
  final bool like, grade, dualPF;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
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


  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$code:$name:$prof:$english:$type:$credit:$time>";
}

List faculty = [
  "전체", "경영경제", "국제어문", "공간환경시스템", "글로벌리더십", "기계제어", "법학부", "상담복지", "생명과학", "언론정보", "전산전자", "콘텐츠융합디자인", "ICT창업",
];

List type = [
  "전체", "실선", "실필", "교필", "교선", "교선필", "전필", "전선", "전선필",
];

List field = [
  "전체", "신앙", "인성", "세계관", "인문학", "사회과학", "자연과학", "리더십", "전공기초", "외국어", "제2외국어", "실무전산", "소통", "융복합", "ICT입문", "프로그래밍기초", "기독교신앙기초",
];

List english = [
  "전체", '0', '100'
];

