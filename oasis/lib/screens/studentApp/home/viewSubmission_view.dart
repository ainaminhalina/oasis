import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oasis/models/user.dart';
import 'package:oasis/screens/studentApp/home/editSubmission_view.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:oasis/models/assignment.dart';
import 'package:oasis/models/submission.dart';
import 'package:oasis/screens/studentApp/home/viewAssignment_view.dart';
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

class ViewSubmissionView extends StatefulWidget {
  const ViewSubmissionView(
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
  _ViewSubmissionViewState createState() => _ViewSubmissionViewState();
}

class _ViewSubmissionViewState extends State<ViewSubmissionView> {
  TextEditingController dateController = TextEditingController();
  TextEditingController fileController = TextEditingController();
  TextEditingController tpController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController(text: widget.submission.submitDate);
    fileController = TextEditingController(text: widget.submission.file);
    tpController = TextEditingController(text: widget.submission.tp);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<StudentHomeViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => StudentHomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: buildSectionBar(context, 'My Submission'),
        body: Stack(
          children: [
            Container(
              height: screenHeight,
              color: Colors.white,
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
                                'Submitted Date:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18),
                              ),
                              SizedBox(height: 5),
                              Text(
                                dateController.text.toString(),
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
                                            url: widget.submission.file.toString(),
                                            fileName: widget.submission.submitDate.toString(),
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
                        Container(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 20, left: 20, right: 20),
                          width: screenWidth,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tahap Penguasaan:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18),
                              ),
                              SizedBox(height: 5),
                              Text(
                                (tpController.text.toString() == "" || tpController.text.toString() == null) ? "Unevaluated" : tpController.text.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        (widget.submission.tp == "")
                            ? Padding(
                                padding: const EdgeInsets.all(15),
                                child: transparentButton("Resubmit Submission",
                                    () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditSubmissionView(
                                              subject: widget.subject,
                                              teacher: widget.teacher,
                                              teachersubjectclassroom:
                                                  widget.teachersubjectclassroom,
                                              assignment: widget.assignment,
                                              submission: widget.submission)));
                                },
                                    Color.fromRGBO(2, 125, 229, 1),
                                    Color.fromRGBO(2, 125, 229, 1),
                                    screenWidth - 30,
                                    textColor: Colors.white),
                              )
                            : Container()
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
