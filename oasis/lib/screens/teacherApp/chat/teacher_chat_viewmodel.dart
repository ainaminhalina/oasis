import 'dart:io';

import 'package:oasis/app/locator.dart';
import 'package:oasis/models/chat.dart';
import 'package:oasis/models/classroom.dart';
import 'package:oasis/models/subject.dart';
import 'package:oasis/models/teachersubjectclassroom.dart';
import 'package:oasis/models/user.dart';
import 'package:oasis/screens/viewmodel.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/chat_service.dart';
import 'package:oasis/services/classroom_service.dart';
import 'package:oasis/services/subject_service.dart';
import 'package:oasis/services/teachersubjectclassroom_service.dart';
import 'package:oasis/services/user_service.dart';

class TeacherChatViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final SubjectService _subjectService = locator<SubjectService>();
  final ClassroomService _classroomService = locator<ClassroomService>();
  final TeacherSubjectClassroomService _teacherSubjectClassroomService =
      locator<TeacherSubjectClassroomService>();
  final ChatService _chatService = locator<ChatService>();
  final UserService _userService = locator<UserService>();

  bool empty = false;

  List<Subject> _subjectList;
  get subjectList => _subjectList;

  List<Classroom> _classroomList;
  get classroomList => _classroomList;

  List<TeacherSubjectClassroom> _teacherSubjectClassroomList;
  get teacherSubjectClassroomList => _teacherSubjectClassroomList;

  List<User> _userList;
  get userList => _userList;

  Future initialise() async {
    setBusy(true);

    _teacherSubjectClassroomList = await _teacherSubjectClassroomService
        .getTeacherSubjectClassroomsByTeacherID(currentUser.id);

    _subjectList = await _subjectService.getSubjects();
    _classroomList = await _classroomService.getClassrooms();
    _userList = await _userService.getUsers();

    if (_teacherSubjectClassroomList.length == 0) empty = true;

    setBusy(false);
  }

  Future createChat({userID, teachersubjectclassroomID, content, createdAt}) async {
    setBusy(true);

    Chat chat = Chat(
        userID: userID,
        teachersubjectclassroomID: teachersubjectclassroomID,
        content: content,
        createdAt: createdAt);

    await _chatService.createChat(chat);

    setBusy(false);
  }

  Subject getSubject(String subjectID) =>
      subjectList.firstWhere((subject) => subject.id == subjectID);

  Classroom getClassroom(String classroomID) =>
      classroomList.firstWhere((classroom) => classroom.id == classroomID);

  User getCurrentUser(String userID) =>
      userList.firstWhere((user) => user.id == userID);
}
