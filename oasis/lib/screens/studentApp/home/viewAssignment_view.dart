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
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300],
                                offset: const Offset(
                                  5.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                width: 0.5,
                                color: dividerColor,
                              ),
                              vertical: BorderSide(
                                width: 0.5,
                                color: dividerColor,
                              ),
                            ),
                          ),
                          child: ListView(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: 30, bottom: 20, left: 20, right: 20),
                                width: screenWidth,
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Title:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      titleController.text.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 20, left: 20, right: 20),
                                width: screenWidth,
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Description:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      descController.text.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 20, left: 20, right: 20),
                                width: screenWidth,
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Start Date:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      startDateController.text.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 20, left: 20, right: 20),
                                width: screenWidth,
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'End Date:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      endDateController.text.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 20, left: 15, right: 15),
                                  width: screenWidth,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'File:',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                              child: InkWell(
                                                child:
                                                  Image.asset('assets/images/doc.jpeg', width: 45),
                                                onTap: () {
                                                  openFile(
                                                    url: widget.assignment.file.toString(),
                                                    fileName: widget.assignment.title.toString(),
                                                  );
                                                },
                                              )
                                          ),
                                          Expanded(
                                            child:
                                              Text(
                                                fileController.text.toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
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
