import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: buildAppBar(context, 'Chat'),
    );
  }
}
