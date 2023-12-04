import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/widget/BigGrayBtn.dart';
import 'package:winit/view/widget/MainAppBar.dart';
import 'package:winit/view/widget/ProjectCard.dart';

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
    return ChangeNotifierProvider(
      create: (_) => null,
      child: MaterialApp(
          home: Scaffold(
        appBar: const MainAppBar(),
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
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
                          onPressed: () {},
                          textColor: Colors.black,
                          fontSize: 12,
                        ),
                        BigGrayBtn(
                          text: '프로젝트 검색',
                          image: "assets/icons/project_search.svg",
                          onPressed: () {},
                          textColor: Colors.black,
                          fontSize: 12,
                        ),
                        BigGrayBtn(
                          text: '프로젝트 검색',
                          image: "assets/icons/project_search.svg",
                          onPressed: () {},
                          textColor: Colors.black,
                          fontSize: 12,
                        ),
                        BigGrayBtn(
                          text: '프로젝트 검색',
                          image: "assets/icons/project_search.svg",
                          onPressed: () {},
                          textColor: Colors.black,
                          fontSize: 12,
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Container(
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
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.13,
                      child: ProjectCard(
                        image: "assets/images/img.png",
                        title: "인테리어 일상ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ",
                        content: "인테리어 일상",
                        writer: "홍길동",
                        location: "서울",
                        date: "2021.09.01",
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.13,
                      child: ProjectCard(
                        image: "assets/images/img.png",
                        title: "인테리어 일상ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ",
                        content: "인테리어 일상",
                        writer: "홍길동",
                        location: "서울",
                        date: "2021.09.01",
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.13,
                      child: ProjectCard(
                        image: "assets/images/img.png",
                        title: "인테리어 일상ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ",
                        content: "인테리어 일상",
                        writer: "홍길동",
                        location: "서울",
                        date: "2021.09.01",
                        onPressed: () {},
                      ),
                    )
                  ]),
                ))),
      )),
    );
  }
}
