import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';

import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) => Scaffold(
              body: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      child: Text(
                                        'Sign Out',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      onTap: () async {
                                        try {
                                          model.signOut(context);
                                          myToast('Signed Out');
                                          return await _auth.signOut();
                                        } catch (e) {
                                          print(e.toString());
                                        }
                                      }),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
