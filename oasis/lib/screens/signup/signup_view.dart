import 'package:flutter/material.dart';
import 'package:oasis/screens/shared/buttons.dart';
import 'package:stacked/stacked.dart';
import 'package:oasis/screens/shared/colors.dart';
import 'package:oasis/screens/shared/styles.dart';

import 'signup_viewmodel.dart';

class SignUpView extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => SignUpView());

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _displayName = '';
  String _email = '';
  String _password = '';
  bool _showPassword = false;
  String _phoneNumber = '';
  String _type = '';

  get displayName => _displayName;
  set displayName(value) => setState(() => _displayName = value);

  get email => _email;
  set email(value) => setState(() => _email = value);

  get password => _password;
  set password(value) => setState(() => _password = value);

  get showPassword => _showPassword;
  set showPassword(value) => setState(() => _showPassword = value);

  get phoneNumber => _phoneNumber;
  set phoneNumber(value) => setState(() => _phoneNumber = value);

  get type => _type;
  set type(value) => setState(() => _type = value);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _builtMyText(),
                    _builtMyText2(),
                    Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            autocorrect: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                labelText: 'FULL NAME',
                                labelStyle: greyBoldText,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: accentColor))),
                            onChanged: (value) => displayName = value,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            autocorrect: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                labelText: 'EMAIL',
                                labelStyle: greyBoldText,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: accentColor))),
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty ||
                                  !value.contains('@') ||
                                  !value.contains('.')) {
                                return ('Please enter a valid email address');
                              }
                            },
                            onChanged: (value) => email = value,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            obscureText: !showPassword,
                            decoration: InputDecoration(
                                labelText: 'PASSWORD',
                                labelStyle: greyBoldText,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off_outlined,
                                    color: showPassword
                                        ? Colors.black54
                                        : Colors.black38,
                                  ),
                                  onPressed: () => showPassword = !showPassword,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: accentColor))),
                            validator: (value) =>
                                value.isEmpty ? 'Password is empty' : null,
                            onChanged: (value) => password = value,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            autocorrect: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                labelText: 'PHONE NUMBER',
                                labelStyle: greyBoldText,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: accentColor))),
                            onChanged: (value) => phoneNumber = value,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            autocorrect: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                labelText: 'TYPE',
                                labelStyle: greyBoldText,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: accentColor))),
                            onChanged: (value) => type = value,
                          ),
                          SizedBox(height: 40.0),
                          BusyButton(
                            height: 40.0,
                            busy: model.isBusy,
                            title: 'SIGN-UP',
                            onPressed: () async {
                              if (_formKey.currentState.validate())
                                model.signUp(
                                    displayName: displayName,
                                    email: email,
                                    password: password,
                                    phoneNumber: phoneNumber,
                                    type: type,
                                    context: context);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                            ),
                          ),
                          SizedBox(width: 5.0),
                          InkWell(
                            onTap: () {
                              model.navigateToSignIn(context);
                            },
                            child: Text(
                              'Sign-In',
                              style: TextStyle(
                                  color: accentColor,
                                  fontFamily: 'Segoe UI',
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _builtMyText() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
            child: Text('Create Your Account',
                style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Container _builtMyText2() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 0.0),
            child: Text(
                'Try the sensation of ease in managing all school activities in one hand',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: grey,
                    fontFamily: 'Segoe UI',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
