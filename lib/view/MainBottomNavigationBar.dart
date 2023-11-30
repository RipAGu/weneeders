import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winit/view/Main/MainPage.dart';
import 'package:winit/view/account/find/ChangePasswordPage.dart';
import 'package:winit/view/account/find/FindAccountPage.dart';
import 'package:winit/view/account/find/FindPasswordPage.dart';
import 'package:winit/view/account/register/CustomerRegisterPage.dart';
import 'package:winit/view/account/register/ExpertRegisterPage.dart';
import 'package:winit/view/account/SignInPage.dart';
import 'package:winit/view/account/register/RegisterAgreePage.dart';
import 'package:winit/view/account/register/RegisterSuccessPage.dart';
import 'package:winit/view/project/DetailProjectPage.dart';

class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MainBottomNavigationBar> createState() =>
      _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  int currentPageIndex = 0;

  final List<Widget> _pages = [
    MainPage(),
    DetailProjectPage(),
    RegisterAgreePage(),
    CustomerRegisterPage(),
    ExpertRegisterPage(),
    ChangePasswordPage()
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        height: 70,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: '검색'
              // activeIcon: Icon(Icons.home),
              ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: '설정',
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.add), label: '추가'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), label: '내정보'),
        ],
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        return SafeArea(child: _pages[index]);
      },
    );
  }
}
