import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oasis/screens/signin/signin_view.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';
import 'package:oasis/screens/shared/colors.dart';
import 'package:oasis/screens/shared/buttons.dart';

import 'student_profile_viewmodel.dart';

class StudentProfileView extends StatefulWidget {
  StudentProfileView();

  @override
  _StudentProfileViewState createState() => _StudentProfileViewState();
}

class _StudentProfileViewState extends State<StudentProfileView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ViewModelBuilder<StudentProfileViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => StudentProfileViewModel(),
        builder: (context, model, child) => Scaffold(
              body: ListView(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    child: FittedBox(
                        fit: BoxFit.contain,
                        child: (model.currentUser.profilePicture == null ||
                                model.currentUser.profilePicture == '')
                            ? CircleAvatar(
                                radius: 50.0,
                                backgroundImage:
                                    AssetImage('assets/images/profile.png'),
                                backgroundColor: Colors.transparent,
                              )
                            : CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(
                                    model.currentUser.profilePicture),
                                backgroundColor: Colors.transparent,
                              )),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    model.currentUser.displayName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 30.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    model.currentUser.email,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      model.navigateToUpdateProfile(context, model.currentUser);
                    },
                    child: Text(
                      'Edit Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 13.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   'ACCOUNT SETTINGS',
                                  //   style: TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.black,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        model.navigateToUpdateProfile(
                                            context, model.currentUser);
                                      },
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child:
                                                  Icon(Icons.person, size: 20),
                                            ),
                                            TextSpan(
                                              text: '            ' +
                                                  model.currentUser.displayName,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      )
                                      // Text(
                                      //   'PHONE NUMBER',
                                      //   style: TextStyle(
                                      //     color: grey,
                                      //   ),
                                      // ),
                                      ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(Icons.phone, size: 20),
                                        ),
                                        TextSpan(
                                          text: '            ' +
                                              model.currentUser.phoneNumber,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(Icons.email, size: 20),
                                        ),
                                        TextSpan(
                                          text: '            ' +
                                              model.currentUser.email,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(Icons.person, size: 20),
                                        ),
                                        TextSpan(
                                          text: '            ' +
                                              model.currentUser.type,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           SizedBox(
                        //             height: 15.0,
                        //           ),
                        //           Text(
                        //             'SUPPORT',
                        //             style: TextStyle(
                        //               fontWeight: FontWeight.normal,
                        //               color: Colors.black,
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: 20.0,
                        //           ),
                        //           Text(
                        //             'Safety Center',
                        //             style: TextStyle(
                        //               color: grey,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           SizedBox(
                        //             height: 40.0,
                        //             child: Divider(
                        //               color: grey,
                        //             ),
                        //           ),
                        //           Text(
                        //             'Get Help',
                        //             style: TextStyle(
                        //               color: grey,
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: 40.0,
                        //             child: Divider(
                        //               color: grey,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             'Give us feedback',
                        //             style: TextStyle(
                        //               color: grey,
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: 40.0,
                        //             child: Divider(
                        //               color: grey,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           SizedBox(
                        //             height: 20.0,
                        //           ),
                        //           Text(
                        //             'LEGAL',
                        //             style: TextStyle(
                        //               fontWeight: FontWeight.normal,
                        //               color: Colors.black,
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: 40.0,
                        //           ),
                        //           Text(
                        //             'Terms of service',
                        //             style: TextStyle(
                        //               color: grey,
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: 40.0,
                        //             child: Divider(
                        //               color: grey,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        transparentButton("SIGN OUT", () async {
                          try {
                            model.signOut(context);
                            myToast('Signed Out');
                            return await _auth.signOut();
                          } catch (e) {
                            print(e.toString());
                          }
                        }, Color.fromRGBO(220, 20, 60, 1),
                            Color.fromRGBO(220, 20, 60, 1), screenWidth / 3,
                            textColor: Colors.white),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           GestureDetector(
                        //               child: Text(
                        //                 'SIGN OUT',
                        //                 style: TextStyle(
                        //                   color: Colors.red,
                        //                 ),
                        //               ),
                        //               onTap: () async {
                        //                 try {
                        //                   model.signOut(context);
                        //                   myToast('Signed Out');
                        //                   return await _auth.signOut();
                        //                 } catch (e) {
                        //                   print(e.toString());
                        //                 }
                        //               }),
                        //           // SizedBox(
                        //           //   height: 40.0,
                        //           //   child: Divider(
                        //           //     color: grey,
                        //           //   ),
                        //           // ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
