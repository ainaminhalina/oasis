import 'package:flutter/material.dart';
import 'package:oasis/models/chat.dart';
import 'package:oasis/models/classroom.dart';
import 'package:oasis/models/subject.dart';
import 'package:oasis/models/teachersubjectclassroom.dart';
import 'package:oasis/screens/shared/colors.dart';
import 'package:oasis/screens/studentApp/chat/chatting_view.dart';

class ChatGroupWidget extends StatelessWidget {
  ChatGroupWidget({this.subject, this.classroom, this.tsc});

  final Subject subject;
  final Classroom classroom;
  final TeacherSubjectClassroom tsc;
  // final List<Chat> chatList;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 15.0, bottom: 3.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
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
          padding: EdgeInsets.only(bottom: 10.5),
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChattingView(
                            subject: subject,
                            classroom: classroom,
                            tsc: tsc)));
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Image.asset('assets/images/chat.png', width: 45),
                  ),
                  Expanded(
                    child: ListTile(
                      dense: true,
                      title: Text(
                        subject.title + ' (' + subject.desc + ')',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w900),
                      ),
                      subtitle: Container(
                        padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              classroom.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
