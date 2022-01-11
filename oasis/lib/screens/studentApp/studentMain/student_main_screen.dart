import 'package:flutter/material.dart';
import 'package:oasis/screens/studentApp/chat/student_chat_view.dart';

import 'package:oasis/screens/studentApp/home/student_home_view.dart';
import 'package:oasis/screens/studentApp/notification/student_notification_view.dart';
import 'package:oasis/screens/studentApp/profile/student_profile_view.dart';
import 'package:oasis/screens/studentApp/result/result_view.dart';

class StudentMainScreen extends StatefulWidget {
  StudentMainScreen({this.tab});
  int tab;

  @override
  _StudentMainScreenState createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  int _selectedIndex = 0;
  Widget _currentScreen;

  get selectedIndex => _selectedIndex;
  set selectedIndex(value) => setState(() => _selectedIndex = value);

  get currentScreen => _currentScreen;
  set currentScreen(value) => setState(() => _currentScreen = value);

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.tab;
    if (selectedIndex == 0) {
      currentScreen = StudentHomeView();
    }
    // if (selectedIndex == 1) {
    //   currentScreen = ResultView();
    // }
    if (selectedIndex == 1) {
      currentScreen = StudentChatView();
    }
    // if (selectedIndex == 3) {
    //   currentScreen = StudentNotificationView();
    // }
    if (selectedIndex == 2) {
      currentScreen = StudentProfileView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: _buildTabBar(),
    );
  }

  BottomNavigationBar _buildTabBar() {
    return BottomNavigationBar(
      // showSelectedLabels: false,
      // showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Classes',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.pages),
        //   label: '',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.notifications),
        //   label: '',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    selectedIndex = index;

    if (selectedIndex == 0) {
      currentScreen = StudentHomeView();
    }
    // if (selectedIndex == 1) {
    //   currentScreen = ResultView();
    // }
    if (selectedIndex == 1) {
      currentScreen = StudentChatView();
    }
    // if (selectedIndex == 3) {
    //   currentScreen = StudentNotificationView();
    // }
    if (selectedIndex == 2) {
      currentScreen = StudentProfileView();
    }
  }
}
