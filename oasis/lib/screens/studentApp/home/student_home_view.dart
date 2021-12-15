import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oasis/screens/shared/appBar.dart';
import 'package:oasis/screens/studentApp/home/subject_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';

import 'student_home_viewmodel.dart';

class StudentHomeView extends StatefulWidget {
  StudentHomeView();

  @override
  _StudentHomeViewState createState() => _StudentHomeViewState();
}

class _StudentHomeViewState extends State<StudentHomeView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentHomeViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => StudentHomeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(context, 'Classes'),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.empty
                ? Column(
                    children: [
                      Expanded(child: Center(child: Text('No Data'))),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: model.teachersubjectclassroomList == null
                              ? 1
                              : model.teachersubjectclassroomList.length,
                          itemBuilder: (context, index) {
                            final tsc =
                                model.teachersubjectclassroomList[index];
                            return SubjectWidget(
                                subject: model.getSubject(tsc.subjectID),
                                teacher: model.getUser(tsc.teacherID),
                                teachersubjectclassroom: tsc);
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
