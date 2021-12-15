import 'package:flutter/material.dart';
import 'package:oasis/models/chat.dart';
import 'package:oasis/models/classroom.dart';
import 'package:oasis/models/subject.dart';
import 'package:oasis/models/teachersubjectclassroom.dart';
import 'package:oasis/screens/shared/round_input.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import 'package:oasis/screens/shared/appBar.dart';
import 'package:oasis/screens/shared/colors.dart';

import 'teacher_chat_viewmodel.dart';

class ChattingView extends StatefulWidget {
  ChattingView({this.subject, this.classroom, this.tsc, this.chatList});

  final Subject subject;
  final Classroom classroom;
  final TeacherSubjectClassroom tsc;
  final List<Chat> chatList;

  @override
  _ChattingViewState createState() => _ChattingViewState();
}

class _ChattingViewState extends State<ChattingView> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TeacherChatViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => TeacherChatViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: buildAppBar(
                  context, widget.subject.title + ' ' + widget.classroom.name),
              body: Center(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: _buildMessageDisplay(),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RoundInput(
                              textController: _textController,
                              // handleSubmitted: (String text) {
                              //   _handleSubmittedLocal();
                              // },
                              // handleChange: _handleChange,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          GestureDetector(
                            // onTap: _handleSubmittedLocal,
                            child: CircleAvatar(
                              child: Icon(Icons.send),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  Widget _buildMessageDisplay() {
    return ListView.builder(
      itemCount: widget.chatList.length,
      itemBuilder: (context, index) {
        final chat = widget.chatList[index];

        return Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 5.0),
          child: Column(
            children: [
              SizedBox(
                height: 8.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    //BoxShadow
                    BoxShadow(
                      color: Colors.green[200],
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
                    // onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) =>
                    //               ChattingView(chatGroup: chatGroup, chatList: chatList)));
                    // },
                    child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        dense: true,
                        title: Text(
                          chat.content,
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
                                chat.createdAt,
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
            ],
          ),
        );
      },
    );
  }
}
