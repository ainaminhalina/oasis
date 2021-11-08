import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oasis/app/locator.dart';
import 'package:oasis/screens/signin/signin_view.dart';
import 'package:oasis/screens/viewmodel.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/screens/shared/toastAndDialog.dart';

class SignUpViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future signUp({
    @required String displayName,
    @required String email,
    @required String password,
    @required String phoneNumber,
    @required context,
  }) async {
    setBusy(true);

    var result = await _authenticationService.registerWithEmailAndPassword(
      displayName: displayName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    );

    setBusy(false);

    if (result is String) {
      awesomeSingleDialog(context, 'Sign-Up Error', result,
          () => Navigator.of(context, rootNavigator: true).pop());
    } else {
      if (result != null) {
        // await Future.delayed(Duration(seconds: 1));
        // await Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => MainScreen(tab: 0)));
      } else {
        awesomeSingleDialog(
            context,
            'Sign-Up Error',
            'General sign-up failure. Please try again later',
            () => Navigator.of(context, rootNavigator: true).pop());
      }
    }
  }

  void navigateToSignIn(context) {
    Navigator.of(context, rootNavigator: true)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignInView()));
  }
}
