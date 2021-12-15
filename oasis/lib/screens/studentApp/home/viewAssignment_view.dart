import 'dart:io';

import 'package:oasis/models/user.dart';
import 'package:oasis/screens/studentApp/home/addSubmission_view.dart';
import 'package:oasis/screens/studentApp/home/viewSubmission_view.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oasis/models/assignment.dart';
import 'package:oasis/models/classroom.dart';
import 'package:oasis/models/subject.dart';
import 'package:oasis/models/teachersubjectclassroom.dart';
import 'package:stacked/stacked.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:oasis/screens/shared/appBar.dart';
import 'package:oasis/screens/shared/textField.dart';
import 'package:oasis/screens/shared/buttons.dart';
import 'package:oasis/screens/shared/colors.dart';
import 'package:oasis/screens/shared/divider.dart';
import 'package:oasis/screens/shared/toastAndDialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'student_home_viewmodel.dart';

class ViewAssignmentView extends StatefulWidget {
  const ViewAssignmentView(
      {this.subject,
      this.teacher,
      this.teachersubjectclassroom,
      this.assignment});

  final Subject subject;
  final User teacher;
  final TeacherSubjectClassroom teachersubjectclassroom;
  final Assignment assignment;

  @override
  _ViewAssignmentViewState createState() => _ViewAssignmentViewState();
}

class _ViewAssignmentViewState extends State<ViewAssignmentView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController fileController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // File _imageFile;

  // Future<void> _pickImage(ImageSource source) async {
  //   PickedFile selected = await ImagePicker().getImage(source: source);

  //   setState(() {
  //     _imageFile = File(selected.path);
  //   });
  // }

  // void _clear() {
  //   setState(() {
  //     _imageFile = null;
  //   });
  // }

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

    return ViewModelBuilder<StudentHomeViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => StudentHomeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: buildSectionBar(context, widget.assignment.title),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Container(
                    height: screenHeight,
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: 15, bottom: 20, left: 15, right: 15),
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
                                  readOnly: true,
                                ),
                              ],
                            ),
                          ),
                          awesomeDivider(0.8, dividerColor),
                          Container(
                            padding: EdgeInsets.only(
                                top: 15, bottom: 20, left: 15, right: 15),
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
                                  readOnly: true,
                                ),
                              ],
                            ),
                          ),
                          awesomeDivider(0.8, dividerColor),
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
                                awesomeTextField(
                                  startDateController,
                                  'Tap to enter assignment start date...',
                                  1,
                                  10,
                                  screenWidth,
                                  TextInputType.multiline,
                                  'start date',
                                  readOnly: true,
                                ),
                              ],
                            ),
                          ),
                          awesomeDivider(0.8, dividerColor),
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
                                awesomeTextField(
                                  endDateController,
                                  'Tap to enter assignment end date...',
                                  1,
                                  10,
                                  screenWidth,
                                  TextInputType.multiline,
                                  'end date',
                                  readOnly: true,
                                ),
                              ],
                            ),
                          ),
                          awesomeDivider(0.8, dividerColor),
                          InkWell(
                            child: Container(
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
                                  awesomeTextField(
                                    fileController,
                                    'No assignment...',
                                    1,
                                    10,
                                    screenWidth,
                                    TextInputType.multiline,
                                    'file',
                                    readOnly: true,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              openFile(
                                url: widget.assignment.file.toString(),
                                fileName: widget.assignment.title.toString(),
                              );
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          (model.hasSubmission(widget.assignment.id))
                              ? Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: transparentButton("View Submission",
                                      () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewSubmissionView(
                                                    subject: widget.subject,
                                                    teacher: widget.teacher,
                                                    teachersubjectclassroom: widget
                                                        .teachersubjectclassroom,
                                                    assignment:
                                                        widget.assignment,
                                                    submission: model
                                                        .getSubmission(widget
                                                            .assignment.id))));
                                  },
                                      Color.fromRGBO(2, 125, 229, 1),
                                      Color.fromRGBO(2, 125, 229, 1),
                                      screenWidth - 30,
                                      textColor: Colors.white),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: transparentButton("Add Submission",
                                      () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddSubmissionView(
                                                subject: widget.subject,
                                                teacher: widget.teacher,
                                                teachersubjectclassroom: widget
                                                    .teachersubjectclassroom,
                                                assignment:
                                                    widget.assignment)));
                                  },
                                      Color.fromRGBO(2, 125, 229, 1),
                                      Color.fromRGBO(2, 125, 229, 1),
                                      screenWidth - 30,
                                      textColor: Colors.white),
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future openFile({String url, String fileName}) async {
    final file = await downloadFile(url, fileName);

    if (file == null) return;

    OpenFile.open(file.path);
  }

  Future<File> downloadFile(String url, String fileName) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/' + basename(url));

    try {
      final response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
          ));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }
}
