import 'package:flutter/material.dart';
import 'package:oasis/screens/teacherApp/chat/teacher_chat_view.dart';

import 'package:oasis/screens/teacherApp/home/teacher_home_view.dart';
import 'package:oasis/screens/teacherApp/notification/teacher_notification_view.dart';
import 'package:oasis/screens/teacherApp/profile/teacher_profile_view.dart';
import 'package:oasis/screens/teacherApp/report/report_view.dart';

class TeacherMainScreen extends StatefulWidget {
  TeacherMainScreen({this.tab});
  int tab;

  @override
  _TeacherMainScreenState createState() => _TeacherMainScreenState();
}

class _TeacherMainScreenState extends State<TeacherMainScreen> {
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
      currentScreen = TeacherHomeView();
    }
    // if (selectedIndex == 1) {
    //   currentScreen = ReportView();
    // }
    if (selectedIndex == 1) {
      currentScreen = TeacherChatView();
    }
    // if (selectedIndex == 3) {
    //   currentScreen = TeacherNotificationView();
    // }
    if (selectedIndex == 2) {
      currentScreen = TeacherProfileView();
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
      currentScreen = TeacherHomeView();
    }
    // if (selectedIndex == 1) {
    //   currentScreen = ReportView();
    // }
    if (selectedIndex == 1) {
      currentScreen = TeacherChatView();
    }
    // if (selectedIndex == 3) {
    //   currentScreen = TeacherNotificationView();
    // }
    if (selectedIndex == 2) {
      currentScreen = TeacherProfileView();
    }
  }
}
