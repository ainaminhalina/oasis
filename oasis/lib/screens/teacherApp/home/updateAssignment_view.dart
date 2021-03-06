import 'dart:io';

import 'package:intl/intl.dart';
import 'package:oasis/screens/teacherApp/teacherMain/teacher_main_screen.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:oasis/models/assignment.dart';
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

import 'teacher_home_viewmodel.dart';

class UpdateAssignmentView extends StatefulWidget {
  const UpdateAssignmentView(
      {this.subject,
      this.classroom,
      this.teachersubjectclassroom,
      this.assignment});

  final Subject subject;
  final Classroom classroom;
  final TeacherSubjectClassroom teachersubjectclassroom;
  final Assignment assignment;

  @override
  _UpdateAssignmentViewState createState() => _UpdateAssignmentViewState();
}

class _UpdateAssignmentViewState extends State<UpdateAssignmentView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController fileController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File file = null;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.assignment.title);
    descController = TextEditingController(text: widget.assignment.desc);
    startDateController =
        TextEditingController(text: widget.assignment.startDate);
    endDateController = TextEditingController(text: widget.assignment.endDate);
    fileController = TextEditingController(text: widget.assignment.file);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<TeacherHomeViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => TeacherHomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: buildSectionBar(context, 'Edit Assignment'),
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
                            'Title:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            titleController,
                            'Tap to enter assignment title...',
                            1,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'title',
                          ),
                        ],
                      ),
                    ),
                    // awesomeDivider(0.8, dividerColor),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 20, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            descController,
                            'Tap to enter assignment description...',
                            6,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'description',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Date:',
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
                                  return ('Please insert Start date');
                                }
                              },
                              controller: startDateController,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 10,
                              readOnly: true,
                              style: TextStyle(color: Colors.black54, fontSize: 13.0, fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: 'Tap to enter assignment start date...',
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
                                    Icons.calendar_today_outlined,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100)
                                    ).then((date) {
                                      setState(() {
                                        var formatter = new DateFormat('dd MMM yyyy');
                                        String startDate = formatter.format(date);
                                        startDateController.text = startDate;
                                      });
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End Date:',
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
                                  return ('Please insert End date');
                                }
                              },
                              controller: endDateController,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 10,
                              readOnly: true,
                              style: TextStyle(color: Colors.black54, fontSize: 13.0, fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: 'Tap to enter assignment end date...',
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
                                    Icons.calendar_today_outlined,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100)
                                    ).then((date) {
                                      setState(() {
                                        var formatter = new DateFormat('dd MMM yyyy');
                                        String endDate = formatter.format(date);
                                        endDateController.text = endDate;
                                      });
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
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
                      child: transparentButton("Update Assignment", () async {
                        if (_formKey.currentState.validate()) {
                          model.updateAssignment(
                            id: widget.assignment.id,
                            title: titleController.text.toString(),
                            desc: descController.text.toString(),
                            startDate: startDateController.text.toString(),
                            endDate: endDateController.text.toString(),
                            file: file,
                          );
                          await Future.delayed(Duration(seconds: 1));
                          awesomeToast('Assignment Updated!');
                          // Navigator.of(context, rootNavigator: true)
                          //     .pushAndRemoveUntil(
                          //         MaterialPageRoute(
                          //             builder: (context) => SubjectView(
                          //                 subject: widget.subject,
                          //                 classroom: widget.classroom,
                          //                 teachersubjectclassroom:
                          //                     widget.teachersubjectclassroom)),
                          //         (route) => false);
                          // Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TeacherMainScreen(tab: 0)));
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
