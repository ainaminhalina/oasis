import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'signin_viewmodel.dart';

class SignInView extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => SignInView());

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _showPassword = false;

  get email => _email;
  set email(value) => setState(() => _email = value);

  get password => _password;
  set password(value) => setState(() => _password = value);

  get showPassword => _showPassword;
  set showPassword(value) => setState(() => _showPassword = value);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => SignInViewModel(),
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
                    Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            autocorrect: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                labelText: 'EMAIL',
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(3, 161, 164, 1)))),
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
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
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
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(3, 161, 164, 1)))),
                            validator: (value) =>
                                value.isEmpty ? 'Password is empty' : null,
                            onChanged: (value) => password = value,
                          ),
                          SizedBox(height: 40.0),
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
                            'Haven\'t signed up?',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                            ),
                          ),
                          SizedBox(width: 5.0),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'Sign-Up',
                              style: TextStyle(
                                  color: Color.fromRGBO(3, 161, 164, 1),
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
            padding: EdgeInsets.fromLTRB(16.0, 135.0, 0.0, 0.0),
            child: Text('MotoKar',
                style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
