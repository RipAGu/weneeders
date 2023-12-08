import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:winit/view/widget/MainAppBar.dart';

class DetailProjectPage extends StatefulWidget {
  const DetailProjectPage({Key? key}) : super(key: key);

  @override
  State<DetailProjectPage> createState() => _DetailProjectPageState();
}

class _DetailProjectPageState extends State<DetailProjectPage> {
  final controller = PageController(viewportFraction: 1.0, keepPage: true);
  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        6,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Center(
                  child: Text(
                "Page $index",
                style: TextStyle(color: Colors.indigo),
              )),
            ));

    return ChangeNotifierProvider(
      create: (_) => null,
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: MainAppBar(),
          body: SafeArea(
            child: Stack(children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                  child: Column(
                    children: [
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
                      Container(
                        //피드 내용
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                          "방화문 필름 리폼(밀크화이트) 가격, 낮은 수납장 설치/ 센서 등은 매립으로 설치. 안녕하세요. 이즈디자인 그룹 입니다. 37평 구축 아파트 인테리어 ",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 240,
                        child: PageView.builder(
                          itemBuilder: (_, index) {
                            return pages[index % pages.length];
                          },
                          controller: controller,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: SmoothPageIndicator(
                            controller: controller,
                            count: pages.length,
                            effect: const ScrollingDotsEffect(
                              activeDotColor: Colors.indigoAccent,
                              activeStrokeWidth: 10,
                              activeDotScale: 1.7,
                              maxVisibleDots: 5,
                              radius: 8,
                              dotHeight: 5,
                              dotWidth: 5,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                  width: double.infinity,
                  height: 45,
                  color: Color(0xFFF2F6F8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/img.png"),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: const CupertinoTextField(
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          placeholder: "댓글을 남겨주세요.",
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/send.svg",
                          )),
                    ],
                  ),
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
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                "assets/icons/trash.svg",
                                height: 50,
                              )),
                        ],
                      ),
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
      ),
    );
  }
}
