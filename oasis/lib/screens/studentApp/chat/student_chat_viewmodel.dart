import 'dart:io';

import 'package:oasis/app/locator.dart';
import 'package:oasis/models/chat.dart';
import 'package:oasis/models/classroom.dart';
import 'package:oasis/models/studentclassroom.dart';
import 'package:oasis/models/subject.dart';
import 'package:oasis/models/teachersubjectclassroom.dart';
import 'package:oasis/models/user.dart';
import 'package:oasis/screens/viewmodel.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/chat_service.dart';
import 'package:oasis/services/classroom_service.dart';
import 'package:oasis/services/studentclassroom_service.dart';
import 'package:oasis/services/subject_service.dart';
import 'package:oasis/services/teachersubjectclassroom_service.dart';
import 'package:oasis/services/user_service.dart';

class StudentChatViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final SubjectService _subjectService = locator<SubjectService>();
  final ClassroomService _classroomService = locator<ClassroomService>();
  final TeacherSubjectClassroomService _teacherSubjectClassroomService =
      locator<TeacherSubjectClassroomService>();
  final StudentClassroomService _studentclassroomService =
      locator<StudentClassroomService>();
  final ChatService _chatService = locator<ChatService>();
  final UserService _userService = locator<UserService>();

  bool empty = false;

  List<Subject> _subjectList;
  get subjectList => _subjectList;

  List<Classroom> _classroomList;
  get classroomList => _classroomList;

  List<TeacherSubjectClassroom> _teacherSubjectClassroomList;
  get teacherSubjectClassroomList => _teacherSubjectClassroomList;

  List<StudentClassroom> _studentClassroomList;
  get studentClassroomList => _studentClassroomList;

  List<User> _userList;
  get userList => _userList;

  Future initialise() async {
    setBusy(true);

    _studentClassroomList = await _studentclassroomService
        .getStudentClassroomsByStudentID(currentUser.id);

    if (_studentClassroomList.length == 0) {
      empty = true;
    } else {
      _teacherSubjectClassroomList = await _teacherSubjectClassroomService
          .getTeacherSubjectClassroomsByClassroomID(
              _studentClassroomList[0].classroomID);
    }

    if (teacherSubjectClassroomList == 0) {
      empty = true;
    }

    _subjectList = await _subjectService.getSubjects();
    _classroomList = await _classroomService.getClassrooms();
    _userList = await _userService.getUsers();

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
