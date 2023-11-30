import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DetailProjectPage extends StatefulWidget {
  const DetailProjectPage({Key? key}) : super(key: key);

  @override
  State<DetailProjectPage> createState() => _DetailProjectPageState();
}

class _DetailProjectPageState extends State<DetailProjectPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => null,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: null,
                            icon: SvgPicture.asset(
                                "assets/icons/icon_profile.svg")),
                        SvgPicture.asset(
                          "assets/icons/logo.svg",
                          width: MediaQuery.of(context).size.width * 0.2,
                          semanticsLabel: "logo",
                        ),
                        IconButton(
                            onPressed: null,
                            icon: SvgPicture.asset("assets/icons/menu.svg"))
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      //구분선
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    Container(
                      //작성자 정보
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          RichText(
                              text: const TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                  children: <TextSpan>[
                                TextSpan(text: "제목: "),
                                TextSpan(
                                    text: "인테리어 일상",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ])),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    children: <TextSpan>[
                                  TextSpan(text: "작성자: "),
                                  TextSpan(
                                      text: "홍길동",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ])),
                          ),
                          const Spacer(),
                          const Text(
                            '2023.03.15 08:15',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Container(//피드 내용

                        )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 45,
                color: Colors.red,
              ),
            )
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.all(0),
          color: const Color(0x00000000),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                  color: Color(0xFFA8B0B8),
                  width: 0.5,
                ))),
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
            height: 60,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/icons/trash.svg",
                          height: 50,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/icons/edit.svg",
                          height: 50,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/icons/backarrow.svg",
                          height: 50,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
