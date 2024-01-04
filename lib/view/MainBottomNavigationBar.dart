import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:winit/view/Main/MainPage.dart';
import 'package:winit/view/chat/ChatListPage.dart';
import 'package:winit/view/project/Search/SearchPartnerPage.dart';
import 'package:winit/view/project/Search/SearchProjectPage.dart';

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
    const SearchPartnerPage(),
    const ChatListPage()
  ];

  bool isFirstPage() {
    if (currentPageIndex == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: _pages[currentPageIndex],
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.09,
        child: PopScope(
          canPop: isFirstPage(),
          onPopInvoked: (bool didPop) {
            if (!didPop) {
              setState(() {
                currentPageIndex = 0;
              });
            }
          },
          child: BottomNavigationBar(
              key: bottomNavBarKey,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: const Color(0xff2D8DF4),
              unselectedItemColor: const Color(0xff7D8791),
              selectedFontSize: 10,
              unselectedFontSize: 10,
              currentIndex: currentPageIndex,
              onTap: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/home.svg",
                      colorFilter: currentPageIndex == 0
                          ? const ColorFilter.mode(
                              Color(0xff2D8DF4), BlendMode.srcIn)
                          : const ColorFilter.mode(
                              Color(0xff7D8791), BlendMode.srcIn)),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/search_project_gray.svg",
                      colorFilter: currentPageIndex == 1
                          ? const ColorFilter.mode(
                              Color(0xff2D8DF4), BlendMode.srcIn)
                          : const ColorFilter.mode(
                              Color(0xff7D8791), BlendMode.srcIn)),
                  label: '프로젝트 검색',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/partner_search.svg",
                      colorFilter: currentPageIndex == 2
                          ? const ColorFilter.mode(
                              Color(0xff2D8DF4), BlendMode.srcIn)
                          : const ColorFilter.mode(
                              Color(0xff7D8791), BlendMode.srcIn)),
                  label: '파트너 검색',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/chat.svg",
                      colorFilter: currentPageIndex == 3
                          ? const ColorFilter.mode(
                              Color(0xff2D8DF4), BlendMode.srcIn)
                          : const ColorFilter.mode(
                              Color(0xff7D8791), BlendMode.srcIn)),
                  label: '채팅',
                ),
              ]),
        ),
      ),
    ));
  }
}
