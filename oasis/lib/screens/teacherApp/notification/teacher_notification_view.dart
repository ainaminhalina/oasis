import 'package:flutter/material.dart';
import 'package:oasis/screens/teacherApp/home/subject_widget.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';
import 'package:oasis/screens/shared/appBar.dart';

import 'teacher_notification_viewmodel.dart';

class TeacherNotificationView extends StatefulWidget {
  TeacherNotificationView();

  @override
  _TeacherNotificationViewState createState() =>
      _TeacherNotificationViewState();
}

class _TeacherNotificationViewState extends State<TeacherNotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Notification'),
    );
  }
}
