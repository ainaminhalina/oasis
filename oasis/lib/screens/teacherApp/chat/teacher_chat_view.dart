import 'package:flutter/material.dart';
import 'package:oasis/screens/teacherApp/chat/chatGroup_widget.dart';
import 'package:oasis/screens/teacherApp/home/subject_widget.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';
import 'package:oasis/screens/shared/appBar.dart';

import 'teacher_chat_viewmodel.dart';

class TeacherChatView extends StatefulWidget {
  TeacherChatView();

  @override
  _TeacherChatViewState createState() => _TeacherChatViewState();
}

class _TeacherChatViewState extends State<TeacherChatView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TeacherChatViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => TeacherChatViewModel(),
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
