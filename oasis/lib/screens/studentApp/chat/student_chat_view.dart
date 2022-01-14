import 'package:flutter/material.dart';
import 'package:oasis/screens/studentApp/chat/chatGroup_widget.dart';
import 'package:oasis/screens/studentApp/home/subject_widget.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';
import 'package:oasis/screens/shared/appBar.dart';

import 'student_chat_viewmodel.dart';

class StudentChatView extends StatefulWidget {
  StudentChatView();

  @override
  _StudentChatViewState createState() => _StudentChatViewState();
}

class _StudentChatViewState extends State<StudentChatView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentChatViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => StudentChatViewModel(),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) => Scaffold(
              appBar: buildAppBar(context, 'Chat'),
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
                                itemCount: model.teacherSubjectClassroomList ==
                                        null
                                    ? 1
                                    : model.teacherSubjectClassroomList.length,
                                itemBuilder: (context, index) {
                                  final tsc =
                                      model.teacherSubjectClassroomList[index];
                                  return ChatGroupWidget(
                                    subject: model.getSubject(tsc.subjectID),
                                    classroom:
                                        model.getClassroom(tsc.classroomID),
                                    tsc: tsc,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
            ));
  }
}
