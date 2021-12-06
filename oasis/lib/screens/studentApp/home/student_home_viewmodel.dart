import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oasis/app/locator.dart';
import 'package:oasis/models/studentclassroom.dart';
import 'package:oasis/models/subject.dart';
import 'package:oasis/models/teachersubjectclassroom.dart';
import 'package:oasis/services/user_service.dart';
import 'package:oasis/screens/viewmodel.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/studentclassroom_service.dart';
import 'package:oasis/services/teachersubjectclassroom_service.dart';
import 'package:oasis/services/subject_service.dart';
import 'package:oasis/services/classroom_service.dart';

class StudentHomeViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final UserService _userService = locator<UserService>();
  final SubjectService _subjectService = locator<SubjectService>();
  final ClassroomService _classroomService = locator<ClassroomService>();
  final StudentClassroomService _studentclassroomService =
      locator<StudentClassroomService>();
  final TeacherSubjectClassroomService _teachersubjectclassroomService =
      locator<TeacherSubjectClassroomService>();

  bool empty = false;

  List<User> _userList;
  get userList => _userList;

  List<Subject> _subjectList;
  get subjectList => _subjectList;

  List<TeacherSubjectClassroom> _teachersubjectclassroomList;
  get teachersubjectclassroomList => _teachersubjectclassroomList;

  List<StudentClassroom> _studentClassroomList;
  get studentClassroomList => _studentClassroomList;

  Future initialise() async {
    setBusy(true);

    _studentClassroomList = await _studentclassroomService
        .getStudentClassroomsByStudentID(currentUser.id);

    if (_studentClassroomList.length == 0) {
      empty = true;
    } else {
      _teachersubjectclassroomList = await _teachersubjectclassroomService
          .getTeacherSubjectClassroomsByClassroomID(
              _studentClassroomList[0].classroomID);
    }

    if (_teachersubjectclassroomList == 0) {
      empty = true;
    }

    _userList = await _userService.getUsers();
    _subjectList = await _subjectService.getSubjects();

    setBusy(false);
  }
}
