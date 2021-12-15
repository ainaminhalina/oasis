import 'package:oasis/models/chat.dart';

import 'rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  static final ChatService _instance = ChatService._constructor();
  factory ChatService() {
    return _instance;
  }

  ChatService._constructor();

  final CollectionReference _chatRef =
      FirebaseFirestore.instance.collection('chats');

  Future<Chat> getChat({String id}) async {
    final json = await Rest.get('chats/$id');
    return Chat.fromJson(json);
  }

  Future<List<Chat>> getChats() async {
    final jsonList = await Rest.get('chats');
    final chatList = <Chat>[];

    if (jsonList != null) {
      for (int i = 0; i < jsonList.length; i++) {
        final json = jsonList[i];
        Chat chat = Chat.fromJson(json);
        chatList.add(chat);
      }
    }

    return chatList;
  }

  Future<List<Chat>> getChatsByChatTeacherSubjectClassroomID(
      String teacherSubjectClassroomID) async {
    QuerySnapshot snapshots = await _chatRef
        .where('teacherSubjectClassroomID',
            isEqualTo: teacherSubjectClassroomID)
        .get();
    return snapshots.docs
        .map((snapshot) => Chat.fromSnapshot(snapshot))
        .toList();
  }

  Future createChat(Chat chat) async {
    await Rest.post(
      'chats/',
      data: {
        'content': chat.content,
        'createdAt': chat.createdAt,
        'teachersubjectclassroomID': chat.teachersubjectclassroomID,
        'userID': chat.userID,
      },
    );
  }
}
