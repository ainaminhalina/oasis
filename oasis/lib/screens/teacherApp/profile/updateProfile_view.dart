import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oasis/screens/teacherApp/teacherMain/teacher_main_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:oasis/models/user.dart';
import 'package:oasis/screens/teacherApp/profile/profile_view.dart';
import 'package:oasis/screens/teacherApp/profile/profile_viewmodel.dart';
import 'package:oasis/screens/shared/textField.dart';
import 'package:oasis/screens/shared/buttons.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:oasis/screens/shared/colors.dart';
import 'package:oasis/screens/shared/appBar.dart';
import 'package:oasis/screens/shared/toastAndDialog.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({this.user});
  final User user;

  @override
  _UpdateProfileViewState createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    PickedFile selected = await ImagePicker().getImage(source: source);

    setState(() {
      _imageFile = File(selected.path);
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  void initState() {
    super.initState();

    displayNameController =
        TextEditingController(text: widget.user.displayName);
    phoneNumberController =
        TextEditingController(text: widget.user.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<ProfileViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: buildSectionBar(context, 'Update Profile'),
        body: Stack(
          children: [
            Container(
              height: screenHeight,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: _imageFile != null ? 14 : 30),
                      InkWell(
                        onTap: () {
                          awesomeDoubleButtonDialog(
                              context,
                              'Snap it or Pick it?',
                              'A decent profile picture works best',
                              'Camera',
                              () {
                                _pickImage(ImageSource.camera);
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              'Gallery',
                              () {
                                _pickImage(ImageSource.gallery);
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              });
                        },
                        child: ClipOval(
                          child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.width / 3,
                              color: Colors.grey,
                              child: _imageFile == null &&
                                      (widget.user.profilePicture == '' ||
                                          widget.user.profilePicture == null)
                                  ? Icon(Icons.add_a_photo,
                                      size: 50, color: Colors.white)
                                  : _imageFile != null &&
                                          (widget.user.profilePicture == '' ||
                                              widget.user.profilePicture ==
                                                  null)
                                      ? Image.file(
                                          _imageFile,
                                          fit: BoxFit.cover,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: widget.user.profilePicture,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )),
                        ),
                      ),
                      _imageFile != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.cancel_outlined),
                                    onPressed: _clear)
                              ],
                            )
                          : SizedBox(height: 31),
                      Divider(color: Colors.white),
                      Container(
                        padding: EdgeInsets.only(
                            top: 15, bottom: 20, left: 15, right: 15),
                        width: screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Full name:',
                              style: TextStyle(
                                  color: grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                            SizedBox(height: 5),
                            awesomeTextField(
                              displayNameController,
                              'Tap to enter display name...',
                              1,
                              10,
                              screenWidth,
                              TextInputType.multiline,
                              'Full name',
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.white),
                      Container(
                        padding: EdgeInsets.only(
                            top: 15, bottom: 15, left: 15, right: 15),
                        width: screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone number:',
                              style: TextStyle(
                                  color: grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                            SizedBox(height: 5),
                            awesomeTextField(
                              phoneNumberController,
                              'Tap to enter phone number...',
                              1,
                              9,
                              screenWidth,
                              TextInputType.multiline,
                              'phone number',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: transparentButton("Update", () async {
                          print(displayNameController.text);
                          print(phoneNumberController.text);
                          if (_formKey.currentState.validate()) {
                            if (_imageFile == null &&
                                model.currentUser.profilePicture == '') {
                              awesomeDialog(context, 'Image is empty',
                                  'You have not upload your profile picture. Would you like to proceed without it?',
                                  () async {
                                model.updateProfile(
                                  displayName: displayNameController.text,
                                  phoneNumber: phoneNumberController.text,
                                );
                                await Future.delayed(Duration(seconds: 1));
                                awesomeToast('Information Updated!');
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TeacherMainScreen(tab: 3)));
                              });
                            } else if (model.currentUser.profilePicture != '') {
                              model.updateProfile(
                                  displayName: displayNameController.text,
                                  phoneNumber: phoneNumberController.text);
                              await Future.delayed(Duration(seconds: 1));
                              awesomeToast('Information Updated!');
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TeacherMainScreen(tab: 3)));
                            } else {
                              model.updateProfile(
                                displayName: displayNameController.text,
                                phoneNumber: phoneNumberController.text,
                                imageFile: _imageFile,
                              );
                              await Future.delayed(Duration(seconds: 1));
                              awesomeToast('Information Updated!');
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TeacherMainScreen(tab: 3)));
                            }
                          }
                        }, Color.fromRGBO(2, 125, 229, 1),
                            Color.fromRGBO(2, 125, 229, 1), screenWidth - 30,
                            textColor: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}