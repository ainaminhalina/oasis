import 'rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  static final ChatService _instance = ChatService._constructor();
  factory ChatService() {
    return _instance;
  }

  ChatService._constructor();
}
