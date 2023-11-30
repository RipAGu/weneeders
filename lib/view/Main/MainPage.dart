import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:winit/view/widget/BigGrayBtn.dart';

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
    return CupertinoPageScaffold(
      child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: null, icon: SvgPicture.asset(profile)),
                      SvgPicture.asset(
                        logo,
                        width: MediaQuery.of(context).size.width * 0.2,
                        semanticsLabel: "logo",
                      ),
                      IconButton(onPressed: null, icon: SvgPicture.asset(menu))
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  //실선
                  Container(
                    height: 1,
                    color: Colors.grey[300],
                  ),
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
                          text: 'test',
                          image: logo,
                          onPressed: () {
                            print('test');
                          }),

                      BigGrayBtn(text: 'test', image: logo, onPressed: null),
                      BigGrayBtn(text: 'test', image: logo, onPressed: null),
                      BigGrayBtn(text: 'test', image: logo, onPressed: null),
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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "프로젝트 카테고리",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ])),
          )),
    );
  }
}
