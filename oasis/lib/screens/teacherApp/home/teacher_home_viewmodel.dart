import 'package:oasis/app/locator.dart';
import 'package:oasis/models/user.dart';
import 'package:oasis/models/subject.dart';
import 'package:oasis/models/classroom.dart';
import 'package:oasis/models/teachersubjectclassroom.dart';
import 'package:oasis/screens/viewmodel.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/user_service.dart';
import 'package:oasis/services/subject_service.dart';
import 'package:oasis/services/classroom_service.dart';
import 'package:oasis/services/teachersubjectclassroom_service.dart';

class TeacherHomeViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final UserService _userService = locator<UserService>();
  final SubjectService _subjectService = locator<SubjectService>();
  final ClassroomService _classroomService = locator<ClassroomService>();
  final TeacherSubjectClassroomService _teachersubjectclassroomService =
      locator<TeacherSubjectClassroomService>();

  bool empty = false;

  List<User> _userList;
  get userList => _userList;

  List<Subject> _subjectList;
  get subjectList => _subjectList;

  List<Classroom> _classroomList;
  get classroomList => _classroomList;

  List<TeacherSubjectClassroom> _teachersubjectclassroomList;
  get teachersubjectclassroomList => _teachersubjectclassroomList;

  Future initialise() async {
    setBusy(true);

    _teachersubjectclassroomList = await _teachersubjectclassroomService
        .getTeacherSubjectClassroomsByTeacherID(currentUser.id);

    _userList = await _userService.getUsers();
    _subjectList = await _subjectService.getSubjects();
    _classroomList = await _classroomService.getClassrooms();

    if (_teachersubjectclassroomList.length == 0) empty = true;

    setBusy(false);
  }

  User getCurrentUser(String userID) =>
      userList.firstWhere((user) => user.id == userID);
  Subject getSubject(String subjectID) =>
      subjectList.firstWhere((subject) => subject.id == subjectID);
  Classroom getClassroom(String classroomID) =>
      classroomList.firstWhere((classroom) => classroom.id == classroomID);
}
