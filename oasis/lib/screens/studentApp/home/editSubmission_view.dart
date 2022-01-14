import 'dart:io';

import 'package:oasis/models/assignment.dart';
import 'package:oasis/models/submission.dart';
import 'package:oasis/models/user.dart';
import 'package:oasis/screens/studentApp/home/viewAssignment_view.dart';
import 'package:oasis/screens/studentApp/home/viewSubmission_view.dart';
import 'package:oasis/screens/studentApp/studentMain/student_main_screen.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:oasis/models/classroom.dart';
import 'package:oasis/models/subject.dart';
import 'package:oasis/models/teachersubjectclassroom.dart';
import 'package:oasis/screens/teacherApp/home/subject_view.dart';
import 'package:stacked/stacked.dart';
import 'package:oasis/screens/shared/appBar.dart';
import 'package:oasis/screens/shared/textField.dart';
import 'package:oasis/screens/shared/buttons.dart';
import 'package:oasis/screens/shared/colors.dart';
import 'package:oasis/screens/shared/divider.dart';
import 'package:oasis/screens/shared/toastAndDialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'student_home_viewmodel.dart';

class EditSubmissionView extends StatefulWidget {
  const EditSubmissionView(
      {this.subject,
      this.teacher,
      this.teachersubjectclassroom,
      this.assignment,
      this.submission});
  final Subject subject;
  final User teacher;
  final TeacherSubjectClassroom teachersubjectclassroom;
  final Assignment assignment;
  final Submission submission;

  @override
  _EditSubmissionViewState createState() => _EditSubmissionViewState();
}

class _EditSubmissionViewState extends State<EditSubmissionView> {
  final fileController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File file = null;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<StudentHomeViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => StudentHomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: buildSectionBar(context, 'Resubmit Submission'),
        body: Stack(
          children: [
            Container(
              height: screenHeight,
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 30, bottom: 20, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'File:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: screenWidth,
                            child: TextFormField(
                              autocorrect: false,
                              // ignore: missing_return
                              validator: (val) {
                                if (val.isEmpty) {
                                  return ('Please insert File');
                                }
                              },
                              controller: fileController,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 10,
                              readOnly: true,
                              style: TextStyle(color: Colors.black54, fontSize: 13.0, fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: 'No file selected...',
                                hintStyle: TextStyle(color: Colors.black38, fontSize: 14.0, fontWeight: FontWeight.w400),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(color: dividerColor, width: 0.5)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.file_copy_outlined,
                                    color: Colors.black,
                                  ),
                                  onPressed: () async {
                                    final result = await FilePicker.platform
                                    .pickFiles(allowMultiple: false);

                                    if (result == null) return;
                                    final path = result.files.single.path;

                                    setState(() => file = File(path));

                                    fileController.text = basename(file.path);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: transparentButton("Resubmit Submission", () async {
                        if (_formKey.currentState.validate()) {
                          model.editSubmission(
                            submissionID: widget.submission.id.toString(),
                            file: file,
                          );
                          await Future.delayed(Duration(seconds: 1));
                          awesomeToast('Submission Resubmited!');
                          // Navigator.of(context, rootNavigator: true)
                          //     .pushAndRemoveUntil(
                          //         MaterialPageRoute(
                          //             builder: (context) => ViewSubmissionView(
                          //                 subject: widget.subject,
                          //                 teacher: widget.teacher,
                          //                 teachersubjectclassroom:
                          //                     widget.teachersubjectclassroom,
                          //                 assignment: widget.assignment,
                          //                 submission: widget.submission)),
                          //         (route) => false);
                          // Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            StudentMainScreen(tab: 0)));
                        }
                      }, Color.fromRGBO(2, 125, 229, 1),
                          Color.fromRGBO(2, 125, 229, 1), screenWidth - 30,
                          textColor: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
