import 'package:flutter/material.dart';
import 'package:oasis/screens/teacherApp/home/subject_widget.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';
import 'package:oasis/screens/shared/appBar.dart';

import 'student_notification_viewmodel.dart';

class StudentNotificationView extends StatefulWidget {
  StudentNotificationView();

  @override
  _StudentNotificationViewState createState() =>
      _StudentNotificationViewState();
}

class _StudentNotificationViewState extends State<StudentNotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Notification'),
    );
  }
}
