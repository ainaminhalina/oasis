import 'package:flutter/material.dart';
import 'package:oasis/screens/teacherApp/home/subject_widget.dart';
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
    return Scaffold(
      appBar: buildAppBar(context, 'Chat'),
    );
  }
}
