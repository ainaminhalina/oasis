import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import 'student_chat_viewmodel.dart';

class ChattingView extends StatefulWidget {
  ChattingView({this.subject, this.classroom, this.tsc});

  final Subject subject;
  final Classroom classroom;
  final TeacherSubjectClassroom tsc;

  @override
  _ChattingViewState createState() => _ChattingViewState();
}

class _ChattingViewState extends State<ChattingView> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentChatViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => StudentChatViewModel(),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) => Scaffold(
              appBar: buildAppBar(
                  context, widget.subject.title + ' ' + widget.classroom.name),
              body: model.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : Center(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: _buildMessageDisplay(model),
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
                                  onTap: () async {
                                    var now = new DateTime.now();
                                    var formatter = new DateFormat('dd MMM yyyy hh:mma');
                                    String createdAt = formatter.format(now);

                                    model.createChat(
                                      userID: model.currentUser.id,
                                      teachersubjectclassroomID: widget.tsc.id,
                                      content: _textController.text,
                                      createdAt:createdAt
                                    );
                                  },
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

  Widget _buildMessageDisplay(model) {
    // final chatList = model.getChats(widget.tsc.id);

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("chats")
            .where('teachersubjectclassroomID', isEqualTo: widget.tsc.id)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting) ? Center(child: CircularProgressIndicator()) : ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (ctx, index) {
              final user =
                  model.getCurrentUser(snapshot.data.docs[index]['userID']);
              return Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 25.0, top: 5.0),
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
                            color: (snapshot.data.docs[index]['userID'] ==
                                    model.currentUser.id)
                                ? Colors.blue[200]
                                : Colors.grey[300],
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
                              title: Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      color: Colors.grey[400],
                                      child: user.profilePicture == null ||
                                              user.profilePicture == ''
                                          ? Icon(
                                              Icons.person,
                                              color: black,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: user.profilePicture,
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                    ),
                                  ),
                                  Text(
                                    '   ' + user.displayName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                              subtitle: Container(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data.docs[index]['content'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        child: Text(
                                          snapshot.data.docs[index]
                                              ['createdAt'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
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
        });
    // return ListView.builder(
    //   itemCount: chatList.length,
    //   itemBuilder: (context, index) {
    //     final chat = chatList[index];
    //     final user = model.getCurrentUser(chat.userID);
//
    //     return Padding(
    //       padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 5.0),
    //       child: Column(
    //         children: [
    //           SizedBox(
    //             height: 8.0,
    //           ),
    //           Container(
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(10),
    //                   topRight: Radius.circular(10),
    //                   bottomLeft: Radius.circular(10),
    //                   bottomRight: Radius.circular(10)),
    //               boxShadow: [
    //                 //BoxShadow
    //                 BoxShadow(
    //                   color: (chat.userID == model.currentUser.id)
    //                       ? Colors.blue[200]
    //                       : Colors.grey[300],
    //                   offset: const Offset(0.0, 0.0),
    //                   blurRadius: 0.0,
    //                   spreadRadius: 0.0,
    //                 ), //BoxShadow
    //               ],
    //               border: Border.symmetric(
    //                 horizontal: BorderSide(
    //                   width: 0.5,
    //                   color: dividerColor,
    //                 ),
    //                 vertical: BorderSide(
    //                   width: 0.5,
    //                   color: dividerColor,
    //                 ),
    //               ),
    //             ),
    //             padding: EdgeInsets.only(bottom: 10.5),
    //             child: InkWell(
    //                 // onTap: () {
    //                 //   Navigator.push(
    //                 //       context,
    //                 //       MaterialPageRoute(
    //                 //           builder: (context) =>
    //                 //               ChattingView(chatGroup: chatGroup, chatList: chatList)));
    //                 // },
    //                 child: Row(
    //               children: [
    //                 Expanded(
    //                   child: ListTile(
    //                     dense: true,
    //                     title: Row(
    //                       children: <Widget>[
    //                         ClipRRect(
    //                           borderRadius: BorderRadius.circular(100),
    //                           child: Container(
    //                             height: 40,
    //                             width: 40,
    //                             color: Colors.grey[400],
    //                             child: user.profilePicture == null ||
    //                                     user.profilePicture == ''
    //                                 ? Icon(
    //                                     Icons.person,
    //                                     color: black,
    //                                   )
    //                                 : CachedNetworkImage(
    //                                     imageUrl: user.profilePicture,
    //                                     fit: BoxFit.fill,
    //                                     placeholder: (context, url) => Center(
    //                                         child: CircularProgressIndicator()),
    //                                     errorWidget: (context, url, error) =>
    //                                         Icon(Icons.error),
    //                                   ),
    //                           ),
    //                         ),
    //                         Text(
    //                           '   ' + user.displayName,
    //                           style: TextStyle(
    //                               color: Colors.black,
    //                               fontSize: 15.0,
    //                               fontWeight: FontWeight.w900),
    //                         ),
    //                       ],
    //                     ),
    //                     subtitle: Container(
    //                       padding: EdgeInsets.only(top: 10.0, bottom: 4.0),
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text(
    //                             chat.content,
    //                             style: TextStyle(
    //                                 color: Colors.black,
    //                                 fontSize: 15.0,
    //                                 fontWeight: FontWeight.w400),
    //                           ),
    //                           Align(
    //                             alignment: Alignment.centerRight,
    //                             child: Container(
    //                               child: Text(
    //                                 chat.createdAt,
    //                                 style: TextStyle(
    //                                     color: Colors.black,
    //                                     fontSize: 12.0,
    //                                     fontWeight: FontWeight.w400),
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             )),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
