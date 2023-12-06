import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/Main/MainPage.dart';
import 'package:winit/view/Main/MainViewModel.dart';
import 'package:winit/view/account/find/ChangePasswordPage.dart';
import 'package:winit/view/account/register/CustomerRegisterPage.dart';
import 'package:winit/view/account/register/ExpertRegisterPage.dart';
import 'package:winit/view/account/SignInPage.dart';
import 'package:winit/view/account/register/RegisterAgreePage.dart';
import 'package:winit/view/account/register/RegisterSuccessPage.dart';
import 'package:winit/view/chat/ChatListPage.dart';
import 'package:winit/view/project/DetailProjectPage.dart';
import 'package:winit/view/project/RegisterPartnerPage.dart';
import 'package:winit/view/project/SearchProjectPage.dart';

GlobalKey<_MainBottomNavigationBarState> bottomNavBarKey = GlobalKey();

class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MainBottomNavigationBar> createState() =>
      _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  int currentPageIndex = 0;

  void changeTab(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  final List<Widget> _pages = [
    const MainPage(),
    const SearchProjectPage(),
    const RegisterAgreePage(),
    const RegisterPartnerPage(),
    const ExpertRegisterPage(),
    const ChatListPage()
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        key: bottomNavBarKey,
        backgroundColor: Colors.white,
        height: 70,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              colorFilter: currentPageIndex == 0
                  ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                  : const ColorFilter.mode(Color(0xff7D8791), BlendMode.srcIn),
            ),
            label: '홈 ',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/search_project_gray.svg",
              colorFilter: currentPageIndex == 1
                  ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                  : const ColorFilter.mode(Color(0xff7D8791), BlendMode.srcIn),
            ),
            label: '프로젝트 검색',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/partner_search.svg",
              colorFilter: currentPageIndex == 2
                  ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                  : const ColorFilter.mode(Color(0xff7D8791), BlendMode.srcIn),
            ),
            label: '파트너 검색',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/partner_register.svg",
              colorFilter: currentPageIndex == 3
                  ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                  : const ColorFilter.mode(Color(0xff7D8791), BlendMode.srcIn),
            ),
            label: '파트너 등록',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/project_register.svg",
              colorFilter: currentPageIndex == 4
                  ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                  : const ColorFilter.mode(Color(0xff7D8791), BlendMode.srcIn),
            ),
            label: '프로젝트 등록',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/chat.svg",
              colorFilter: currentPageIndex == 5
                  ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                  : const ColorFilter.mode(Color(0xff7D8791), BlendMode.srcIn),
            ),
            label: '채팅 ',
          ),
        ],
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        return Scaffold(body: _pages[index]);
      },
    );
  }
}
