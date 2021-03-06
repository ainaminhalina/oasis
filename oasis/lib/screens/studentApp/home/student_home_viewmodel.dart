import 'dart:io';

import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:oasis/api/firebase_api.dart';
import 'package:path/path.dart';
import 'package:oasis/models/studentclassroom.dart';
import 'package:oasis/services/assignment_service.dart';
import 'package:oasis/services/studentclassroom_service.dart';
import 'package:oasis/app/locator.dart';
import 'package:oasis/models/submission.dart';
import 'package:oasis/models/user.dart';
import 'package:oasis/models/subject.dart';
import 'package:oasis/models/classroom.dart';
import 'package:oasis/models/teachersubjectclassroom.dart';
import 'package:oasis/models/assignment.dart';
import 'package:oasis/screens/viewmodel.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/submission_service.dart';
import 'package:oasis/services/user_service.dart';
import 'package:oasis/services/subject_service.dart';
import 'package:oasis/services/classroom_service.dart';
import 'package:oasis/services/teachersubjectclassroom_service.dart';

class StudentHomeViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final UserService _userService = locator<UserService>();
  final SubjectService _subjectService = locator<SubjectService>();
  final ClassroomService _classroomService = locator<ClassroomService>();
  final TeacherSubjectClassroomService _teachersubjectclassroomService =
      locator<TeacherSubjectClassroomService>();
  final StudentClassroomService _studentclassroomService =
      locator<StudentClassroomService>();
  final AssignmentService _assignmentService = locator<AssignmentService>();
  final SubmissionService _submissionService = locator<SubmissionService>();

  bool empty = false;
  bool empty2 = false;
  bool empty3 = false;

  List<User> _userList;
  get userList => _userList;

  List<Subject> _subjectList;
  get subjectList => _subjectList;

  List<TeacherSubjectClassroom> _teachersubjectclassroomList;
  get teachersubjectclassroomList => _teachersubjectclassroomList;

  List<StudentClassroom> _studentClassroomList;
  get studentClassroomList => _studentClassroomList;

  List<Assignment> _assignmentList;
  get assignmentList => _assignmentList;

  List<Submission> _submissionList;
  get submissionList => _submissionList;

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
    _assignmentList = await _assignmentService.getAssignments();
    _submissionList = await _submissionService.getSubmissions();

    if (_assignmentList.length == 0) empty2 = true;
    if (_submissionList.length == 0) empty3 = true;

    setBusy(false);
  }

  User getUser(String userID) =>
      userList.firstWhere((user) => user.id == userID);

  Subject getSubject(String subjectID) =>
      subjectList.firstWhere((subject) => subject.id == subjectID);

  bool hasSubmission(String assignmentID) {
    if (_submissionList.length == 0) {
      return false;
    }

    Submission mySubmission = submissionList.firstWhere(
        (submission) =>
            submission.assignmentID == assignmentID &&
            submission.studentID == currentUser.id,
        orElse: () => null);

    if (mySubmission == null) {
      return false;
    } else {
      return true;
    }
  }

  Submission getSubmission(String assignmentID) => submissionList.firstWhere(
      (submission) =>
          submission.assignmentID == assignmentID &&
          submission.studentID == currentUser.id,
      orElse: () => null);

  void createSubmission({assignmentID, File file}) async {
    setBusy(true);

    final fileName = basename(file.path);
    final destination = 'files/$fileName';

    UploadTask task = FirebaseApi.uploadFile(destination, file);

    String fileUrl = '';

    if (task != null) {
      final snapshot = await task.whenComplete(() => {});
      fileUrl = await snapshot.ref.getDownloadURL();
    }

    var now = new DateTime.now();
    var formatter = new DateFormat('dd MMM yyyy');
    String submitDate = formatter.format(now);

    Submission submission = Submission(
        studentID: currentUser.id,
        assignmentID: assignmentID,
        submitDate: submitDate,
        file: fileUrl,
        tp: "");

    await _submissionService.createSubmission(submission);

    setBusy(false);
  }

  void editSubmission({submissionID, File file}) async {
    setBusy(true);

    final fileName = basename(file.path);
    final destination = 'files/$fileName';

    UploadTask task = FirebaseApi.uploadFile(destination, file);

    String fileUrl = '';

    if (task != null) {
      final snapshot = await task.whenComplete(() => {});
      fileUrl = await snapshot.ref.getDownloadURL();
    }

    var now = new DateTime.now();
    var formatter = new DateFormat('dd MMM yyyy');
    String submitDate = formatter.format(now);

    await _submissionService.updateSubmission(
        id: submissionID, submitDate: submitDate, file: fileUrl);

    setBusy(false);
  }

  void updateAssignment(
      {id, title, desc, startDate, endDate, File file}) async {
    setBusy(true);

    if (file != null) {
      final fileName = basename(file.path);
      final destination = 'files/$fileName';

      UploadTask task = FirebaseApi.uploadFile(destination, file);

      String fileUrl = '';

      if (task != null) {
        final snapshot = await task.whenComplete(() => {});
        fileUrl = await snapshot.ref.getDownloadURL();
      }

      await _assignmentService.updateAssignment(
          id: id,
          title: title,
          desc: desc,
          startDate: startDate,
          endDate: endDate,
          file: fileUrl);
    } else {
      await _assignmentService.updateAssignment(
          id: id,
          title: title,
          desc: desc,
          startDate: startDate,
          endDate: endDate);
    }

    setBusy(false);
  }
}
