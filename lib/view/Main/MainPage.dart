import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/MainBottomNavigationBar.dart';
import 'package:winit/view/widget/BigGrayBtn.dart';
import 'package:winit/view/widget/MainAppBar.dart';
import 'package:winit/view/widget/ProjectCard.dart';

import 'MainViewModel.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final String logo = "assets/icons/logo.svg";
  final String profile = "assets/icons/icon_profile.svg";
  final String menu = "assets/icons/menu.svg";
  final String searchImage = "assets/images/search.svg";
  final String whiteLogo = "assets/icons/white_logo.svg";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: const MainAppBar(),
      body: SizedBox(
          width: double.infinity,
          child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SingleChildScrollView(
                child: Column(children: [
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  SvgPicture.asset(
                    searchImage,
                    width: MediaQuery.of(context).size.width * 1,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      //클릭시 로그 출력
                      BigGrayBtn(
                        text: '프로젝트 검색',
                        image: "assets/icons/project_search.svg",
                        onPressed: () {
                          BottomNavigationBar navigationBar = bottomNavBarKey
                              .currentWidget as BottomNavigationBar;
                          navigationBar.onTap!(1);
                        },
                        textColor: Colors.black,
                        fontSize: 12,
                      ),
                      BigGrayBtn(
                        text: '파트너 검색',
                        image: "assets/icons/partner_search.svg",
                        onPressed: () {
                          BottomNavigationBar navigationBar = bottomNavBarKey
                              .currentWidget as BottomNavigationBar;
                          navigationBar.onTap!(2);
                        },
                        textColor: Colors.black,
                        fontSize: 12,
                      ),
                      BigGrayBtn(
                        text: '파트너 등록',
                        image: "assets/icons/partner_register.svg",
                        onPressed: () {},
                        textColor: Colors.black,
                        fontSize: 12,
                      ),
                      BigGrayBtn(
                        text: '프로젝트 등록',
                        image: "assets/icons/project_register.svg",
                        onPressed: () {},
                        textColor: Colors.black,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.43,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: ShapeDecoration(
                        color: const Color(0xff2d8cf4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999)),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x332D8DF4),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            whiteLogo,
                          ),
                          const Padding(padding: EdgeInsets.only(left: 13)),
                          const Text(
                            "위닛헌터 요청",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 40)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "우수 파트너스",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SvgPicture.asset("assets/icons/add_and_text.svg"),
                      ]),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 1,
                    color: Colors.grey[300],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Provider.of<MainViewModel>(context)
                              .mainDataList
                              .length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height * 0.13,
                              child: ProjectCard(
                                image: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .image,
                                title: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .title,
                                content: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .content,
                                writer: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .writer,
                                location: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .location,
                                date: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .date,
                                onPressed: () {},
                              ),
                            );
                          })),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "실시간 프로젝트",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SvgPicture.asset("assets/icons/add_and_text.svg"),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 1,
                    color: Colors.grey[300],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Provider.of<MainViewModel>(context)
                              .mainDataList
                              .length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height * 0.13,
                              child: ProjectCard(
                                image: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .image,
                                title: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .title,
                                content: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .content,
                                writer: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .writer,
                                location: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .location,
                                date: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .date,
                                onPressed: () {},
                              ),
                            );
                          })),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "최신글",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SvgPicture.asset("assets/icons/add_and_text.svg"),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 1,
                    color: Colors.grey[300],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Provider.of<MainViewModel>(context)
                              .mainDataList
                              .length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height * 0.13,
                              child: ProjectCard(
                                image: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .image,
                                title: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .title,
                                content: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .content,
                                writer: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .writer,
                                location: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .location,
                                date: Provider.of<MainViewModel>(context)
                                    .mainDataList[index]
                                    .date,
                                onPressed: () {},
                              ),
                            );
                          })),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                ]),
              ))),
    ));
  }
}
