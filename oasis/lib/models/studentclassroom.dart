import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentClassroom {
  String _id;
  String _studentID;
  String _classroomID;

  get id => _id;
  set id(value) => _id = value;

  get studentID => _studentID;
  set studentID(value) => _studentID = value;

  get classroomID => _classroomID;
  set classroomID(value) => _classroomID = value;

  StudentClassroom({
    String id,
    String studentID,
    String classroomID,
  })  : _id = id,
        _studentID = studentID,
        _classroomID = classroomID;

  factory StudentClassroom.createNew(
          {String id, String studentID, String classroomID}) =>
      StudentClassroom(id: id, studentID: studentID, classroomID: classroomID);

  factory StudentClassroom.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return StudentClassroom.fromJson(json);
  }

  StudentClassroom.copy(StudentClassroom from)
      : this(
            id: from.id,
            studentID: from.studentID,
            classroomID: from.classroomID);

  factory StudentClassroom.fromRawJson(String str) =>
      StudentClassroom.fromJson(jsonDecode(str));

  StudentClassroom.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            studentID: json['studentID'],
            classroomID: json['classroomID']);

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() =>
      {'studentID': studentID, 'classroomID': classroomID};
}
