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
import 'package:oasis/services/assignment_service.dart';

class TeacherHomeViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final UserService _userService = locator<UserService>();
  final SubjectService _subjectService = locator<SubjectService>();
  final ClassroomService _classroomService = locator<ClassroomService>();
  final TeacherSubjectClassroomService _teachersubjectclassroomService =
      locator<TeacherSubjectClassroomService>();
  final AssignmentService _assignmentService = locator<AssignmentService>();
  final SubmissionService _submissionService = locator<SubmissionService>();

  bool empty = false;
  bool empty2 = false;
  bool empty3 = false;

  List<User> _userList;
  get userList => _userList;

  List<Subject> _subjectList;
  get subjectList => _subjectList;

  List<Classroom> _classroomList;
  get classroomList => _classroomList;

  List<TeacherSubjectClassroom> _teachersubjectclassroomList;
  get teachersubjectclassroomList => _teachersubjectclassroomList;

  List<Assignment> _assignmentList;
  get assignmentList => _assignmentList;

  List<Submission> _submissionList;
  get submissionList => _submissionList;

  Future initialise() async {
    setBusy(true);

    _teachersubjectclassroomList = await _teachersubjectclassroomService
        .getTeacherSubjectClassroomsByTeacherID(currentUser.id);

    _userList = await _userService.getUsers();
    _subjectList = await _subjectService.getSubjects();
    _classroomList = await _classroomService.getClassrooms();
    _assignmentList = await _assignmentService.getAssignments();
    _submissionList = await _submissionService.getSubmissions();

    if (_teachersubjectclassroomList.length == 0) empty = true;
    if (_assignmentList.length == 0) empty2 = true;
    if (_submissionList.length == 0) empty3 = true;

    setBusy(false);
  }

  void createAssignment(
      {title,
      desc,
      startDate,
      endDate,
      teachersubjectclassroomID,
      file}) async {
    setBusy(true);

    Assignment assignment = Assignment(
        title: title,
        desc: desc,
        startDate: startDate,
        endDate: endDate,
        teachersubjectclassroomID: teachersubjectclassroomID,
        file: file);

    await _assignmentService.createAssignment(assignment);

    setBusy(false);
  }

  void updateAssignment({id, title, desc, startDate, endDate, file}) async {
    setBusy(true);

    await _assignmentService.updateAssignment(
        id: id,
        title: title,
        desc: desc,
        startDate: startDate,
        endDate: endDate,
        file: file);

    setBusy(false);
  }

  User getCurrentUser(String userID) =>
      userList.firstWhere((user) => user.id == userID);

  Subject getSubject(String subjectID) =>
      subjectList.firstWhere((subject) => subject.id == subjectID);

  Classroom getClassroom(String classroomID) =>
      classroomList.firstWhere((classroom) => classroom.id == classroomID);
}
