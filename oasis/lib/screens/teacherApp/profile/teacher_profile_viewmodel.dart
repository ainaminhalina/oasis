import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oasis/app/locator.dart';
import 'package:oasis/screens/teacherApp/profile/teacher_updateProfile_view.dart';
import 'package:oasis/screens/signin/signin_view.dart';
import 'package:oasis/screens/viewmodel.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/user_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:oasis/api/firebase_api.dart';
import 'package:path/path.dart';

class TeacherProfileViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final UserService _userService = locator<UserService>();

  void updateProfile({
    @required String displayName,
    @required String phoneNumber,
    File imageFile,
  }) async {
    setBusy(true);

    if (imageFile == null || imageFile == '') {
      await _userService.updateUser(
          id: currentUser.id,
          displayName: displayName,
          phoneNumber: phoneNumber);

      currentUser.displayName = displayName;
      currentUser.phoneNumber = phoneNumber;
    } else {
      final fileName = basename(imageFile.path);
      final destination = 'files/$fileName';

      UploadTask task = FirebaseApi.uploadFile(destination, imageFile);

      String fileUrl = '';

      if (task != null) {
        final snapshot = await task.whenComplete(() => {});
        fileUrl = await snapshot.ref.getDownloadURL();
      }

      await _userService.updateUser(
          id: currentUser.id,
          displayName: displayName,
          phoneNumber: phoneNumber,
          profilePicture: fileUrl);

      currentUser.displayName = displayName;
      currentUser.phoneNumber = phoneNumber;
      currentUser.profilePicture = fileUrl;
    }

    setBusy(false);
  }

  void navigateToUpdateProfile(context, user) {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => TeacherUpdateProfileView(user: user)));
  }

  void signOut(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignInView()),
        (route) => false);
  }
}
