import 'rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oasis/models/studentclassroom.dart';

class StudentClassroomService {
  static final StudentClassroomService _instance =
      StudentClassroomService._constructor();
  factory StudentClassroomService() {
    return _instance;
  }

  StudentClassroomService._constructor();

  final CollectionReference _studentclassroomRef =
      FirebaseFirestore.instance.collection('studentclassrooms');

  Future createStudentClassroom(StudentClassroom studentclassroom) async {
    await Rest.post(
      'studentclassrooms/',
      data: {
        'studentID': studentclassroom.studentID,
        'classroomID': studentclassroom.classroomID
      },
    );
  }

  Future<List<StudentClassroom>> getStudentClassroomsByStudentID(
      String studentID) async {
    QuerySnapshot snapshots = await _studentclassroomRef
        .where('studentID', isEqualTo: studentID)
        .get();
    return snapshots.docs
        .map((snapshot) => StudentClassroom.fromSnapshot(snapshot))
        .toList();
  }
}
