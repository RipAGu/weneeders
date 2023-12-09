import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:winit/view/project/DetailViewModel.dart';
import 'package:winit/view/widget/CommentBox.dart';
import 'package:winit/view/widget/ImageBox.dart';
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
    return ChangeNotifierProvider(
      create: (context) => DetailViewModel(),
      child: Consumer<DetailViewModel>(
        builder: (context, viewModel, child) => MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.white,
            appBar: MainAppBar(),
            body: SafeArea(
              child: Stack(children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Container(
                          //작성자 정보
                          margin: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
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
                          margin: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: const Text(
                            "방화문 필름 리폼(밀크화이트) 가격, 낮은 수납장 설치/ 센서 등은 매립으로 설치. 안녕하세요. 이즈디자인 그룹 입니다. 37평 구축 아파트 인테리어 ",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 240,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: PageView.builder(
                              itemCount: viewModel.images.length,
                              itemBuilder: (_, index) {
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: ImageBox(
                                        image: viewModel.images[index]));
                              },
                              controller: controller,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          child: SmoothPageIndicator(
                              controller: controller,
                              count: viewModel.images.length,
                              effect: const ScrollingDotsEffect(
                                activeDotColor: Color(0xff2D8DF4),
                                activeStrokeWidth: 10,
                                activeDotScale: 1.7,
                                maxVisibleDots: 5,
                                radius: 8,
                                dotHeight: 5,
                                dotWidth: 5,
                              )),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.testCommentList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 10),
                                height: 50,
                                child: CommentBox(
                                    name: viewModel.testCommentList[index].name,
                                    date: viewModel.testCommentList[index].date,
                                    comment: viewModel
                                        .testCommentList[index].comment),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    width: double.infinity,
                    height: 45,
                    color: Color(0xFFF2F6F8),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/img.png"),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: double.infinity,
                          child: const CupertinoTextField(
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            placeholder: "댓글을 남겨주세요.",
                            padding: EdgeInsets.symmetric(horizontal: 5),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
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
        ),
      ),
    );
  }
}
