import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chat {
  String _id;
  String _userID;
  String _teachersubjectclassroomID;
  String _content;
  String _createdAt;

  get id => _id;
  set id(value) => _id = value;

  get userID => _userID;
  set userID(value) => _userID = value;

  get teachersubjectclassroomID => _teachersubjectclassroomID;
  set teachersubjectclassroomID(value) => _teachersubjectclassroomID = value;

  get content => _content;
  set content(value) => _content = value;

  get createdAt => _createdAt;
  set createdAt(value) => _createdAt = value;

  Chat({
    String id,
    String userID = '',
    String teachersubjectclassroomID = '',
    String content = '',
    String createdAt = '',
  })  : _id = id,
        _userID = userID,
        _teachersubjectclassroomID = teachersubjectclassroomID,
        _content = content,
        _createdAt = createdAt;

  factory Chat.createNew(
          {String id,
          String userID,
          String teachersubjectclassroomID,
          String content,
          String createdAt}) =>
      Chat(
          id: id,
          userID: userID,
          teachersubjectclassroomID: teachersubjectclassroomID,
          content: content,
          createdAt: createdAt);

  factory Chat.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Chat.fromJson(json);
  }

  Chat.copy(Chat from)
      : this(
            id: from.id,
            userID: from.userID,
            teachersubjectclassroomID: from.teachersubjectclassroomID,
            content: from.content,
            createdAt: from.createdAt);

  factory Chat.fromRawJson(String str) => Chat.fromJson(jsonDecode(str));

  Chat.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            userID: json['userID'],
            teachersubjectclassroomID: json['teachersubjectclassroomID'],
            content: json['content'],
            createdAt: json['createdAt']);

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'teachersubjectclassroomID': teachersubjectclassroomID,
        'content': content,
        'createdAt': createdAt,
      };
}
