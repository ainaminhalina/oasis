import 'package:flutter/material.dart';
import 'package:oasis/models/user.dart';
import 'package:oasis/screens/studentApp/home/assignment_widget.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:oasis/models/subject.dart';
import 'package:oasis/models/classroom.dart';
import 'package:oasis/models/teachersubjectclassroom.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';
import '../../shared/colors.dart';
import 'package:oasis/screens/shared/appBar.dart';

import 'student_home_viewmodel.dart';

class SubjectView extends StatefulWidget {
  SubjectView({this.subject, this.teacher, this.teachersubjectclassroom});
  final Subject subject;
  final User teacher;
  final TeacherSubjectClassroom teachersubjectclassroom;

  @override
  _SubjectViewState createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentHomeViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => StudentHomeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(context, widget.subject.title),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.empty2
                ? Column(
                    children: [
                      Expanded(child: Center(child: Text('No Data'))),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: model.assignmentList == null
                              ? 1
                              : model.assignmentList.length,
                          itemBuilder: (context, index) {
                            final assignment = model.assignmentList[index];

                            if (assignment.teachersubjectclassroomID ==
                                widget.teachersubjectclassroom.id) {
                              return AssignmentWidget(
                                  subject: widget.subject,
                                  teacher: widget.teacher,
                                  teachersubjectclassroom:
                                      widget.teachersubjectclassroom,
                                  assignment: assignment,
                                  submission:
                                      (model.hasSubmission(assignment.id)
                                          ? model.getSubmission(assignment.id)
                                          : null));
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
