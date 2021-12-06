import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Notification {
  String _id;
  String _userID;
  String _title;
  String _desc;
  String _createdAt;
  String _receivedAt;

  get id => _id;
  set id(value) => _id = value;

  get userID => _userID;
  set userID(value) => _userID = value;

  get title => _title;
  set title(value) => _title = value;

  get desc => _desc;
  set desc(value) => _desc = value;

  get createdAt => _createdAt;
  set createdAt(value) => _createdAt = value;

  get receivedAt => _receivedAt;
  set receivedAt(value) => _receivedAt = value;

  Notification({
    String id,
    String userID = '',
    String title = '',
    String desc = '',
    String createdAt = '',
    String receivedAt = '',
  })  : _id = id,
        _userID = userID,
        _title = title,
        _desc = desc,
        _createdAt = createdAt,
        _receivedAt = receivedAt;

  factory Notification.createNew(
          {String id,
          String userID,
          String title,
          String desc,
          String createdAt,
          String receivedAt}) =>
      Notification(
          id: id,
          userID: userID,
          title: title,
          desc: desc,
          createdAt: createdAt,
          receivedAt: receivedAt);

  factory Notification.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Notification.fromJson(json);
  }

  Notification.copy(Notification from)
      : this(
            id: from.id,
            userID: from.userID,
            title: from.title,
            desc: from.desc,
            createdAt: from.createdAt,
            receivedAt: from.receivedAt);

  factory Notification.fromRawJson(String str) =>
      Notification.fromJson(jsonDecode(str));

  Notification.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            userID: json['userID'],
            title: json['title'],
            desc: json['desc'],
            createdAt: json['createdAt'],
            receivedAt: json['receivedAt']);

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'title': title,
        'desc': desc,
        'createdAt': createdAt,
        'receivedAt': receivedAt,
      };
}
