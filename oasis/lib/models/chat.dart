import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chat {
  String _id;
  String _userID;
  String _receiverID;
  String _teachersubjectclassroomID;
  String _content;
  String _createdAt;
  String _receivedAt;

  get id => _id;
  set id(value) => _id = value;

  get userID => _userID;
  set userID(value) => _userID = value;

  get receiverID => _receiverID;
  set receiverID(value) => _receiverID = value;

  get teachersubjectclassroomID => _teachersubjectclassroomID;
  set teachersubjectclassroomID(value) => _teachersubjectclassroomID = value;

  get content => _content;
  set content(value) => _content = value;

  get createdAt => _createdAt;
  set createdAt(value) => _createdAt = value;

  get receivedAt => _receivedAt;
  set receivedAt(value) => _receivedAt = value;

  Chat({
    String id,
    String userID = '',
    String receiverID = '',
    String teachersubjectclassroomID = '',
    String content = '',
    String createdAt = '',
    String receivedAt = '',
  })  : _id = id,
        _userID = userID,
        _receiverID = receiverID,
        _teachersubjectclassroomID = teachersubjectclassroomID,
        _content = content,
        _createdAt = createdAt,
        _receivedAt = receivedAt;

  factory Chat.createNew(
          {String id,
          String userID,
          String receiverID,
          String teachersubjectclassroomID,
          String content,
          String createdAt,
          String receivedAt}) =>
      Chat(
          id: id,
          userID: userID,
          receiverID: receiverID,
          teachersubjectclassroomID: teachersubjectclassroomID,
          content: content,
          createdAt: createdAt,
          receivedAt: receivedAt);

  factory Chat.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Chat.fromJson(json);
  }

  Chat.copy(Chat from)
      : this(
            id: from.id,
            userID: from.userID,
            receiverID: from.receiverID,
            teachersubjectclassroomID: from.teachersubjectclassroomID,
            content: from.content,
            createdAt: from.createdAt,
            receivedAt: from.receivedAt);

  factory Chat.fromRawJson(String str) => Chat.fromJson(jsonDecode(str));

  Chat.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            userID: json['userID'],
            receiverID: json['receiverID'],
            teachersubjectclassroomID: json['teachersubjectclassroomID'],
            content: json['content'],
            createdAt: json['createdAt'],
            receivedAt: json['receivedAt']);

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'receiverID': receiverID,
        'teachersubjectclassroomID': teachersubjectclassroomID,
        'content': content,
        'createdAt': createdAt,
        'receivedAt': receivedAt
      };
}
