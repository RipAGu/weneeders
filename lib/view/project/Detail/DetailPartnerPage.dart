import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widget/CommentBox.dart';
import '../../widget/ImageBox.dart';
import '../../widget/MainAppBar.dart';
import 'DetailViewModel.dart';

class DetailPartnerPage extends StatefulWidget {
  final int idx;
  const DetailPartnerPage({Key? key, required this.idx}) : super(key: key);

  @override
  State<DetailPartnerPage> createState() => _DetailPartnerPageState();
}

class _DetailPartnerPageState extends State<DetailPartnerPage> {
  late int idx;
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  Future<void> loadData() async {
    await Provider.of<DetailViewModel>(context, listen: false)
        .getPartnerDetail(idx);
    await Provider.of<DetailViewModel>(context, listen: false)
        .getPartnerComment(idx);
  }

  @override
  void initState() {
    super.initState();
    idx = widget.idx;
  }

  @override
  void deactivate() {
    Provider.of<DetailViewModel>(context, listen: false).clearData();
    super.deactivate();
  }

  final controller = PageController(viewportFraction: 1.0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<DetailViewModel>(
            builder: (context, viewModel, child) => MaterialApp(
              home: Scaffold(
                backgroundColor: Colors.white,
                appBar: const MainAppBar(),
                body: SafeArea(
                  child: Stack(children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Column(
                          children: [
                            Container(
                              //작성자 정보
                              margin: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                          children: <TextSpan>[
                                        const TextSpan(text: "작성자: "),
                                        TextSpan(
                                            text: viewModel
                                                .partnerDetailData.User.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                      ])),
                                  const Spacer(),
                                  Text(
                                    viewModel.partnerDetailData.createdAt,
                                    style: const TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                      children: <TextSpan>[
                                    const TextSpan(text: "지역: "),
                                    TextSpan(
                                        text: viewModel.partnerRegion,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ])),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                      children: <TextSpan>[
                                    const TextSpan(text: "업무 방식: "),
                                    TextSpan(
                                        text:
                                            viewModel.partnerDetailData.method,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ])),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                      children: <TextSpan>[
                                    const TextSpan(text: "전문 분야: "),
                                    TextSpan(
                                        text: viewModel.partnerField,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ])),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                      children: <TextSpan>[
                                    const TextSpan(text: "사용 기술: "),
                                    TextSpan(
                                        text: viewModel.partnerSkill,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ])),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              //피드 내용
                              margin: const EdgeInsets.only(top: 10),
                              child: Text(
                                viewModel.projectDetailData.method,
                                style: const TextStyle(fontSize: 12),
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
                                    return ImageBox(
                                        image: viewModel.images[index]);
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
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: viewModel.partnerCommentList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    child: CommentBox(
                                      name: viewModel.partnerCommentList[index]
                                          .User.nickname,
                                      date: viewModel
                                          .partnerCommentList[index].createdAt,
                                      comment: viewModel
                                          .partnerCommentList[index].contents,
                                      repleData: viewModel
                                          .partnerCommentList[index]
                                          .PartnerReplyComment,
                                      repleOnTap: () {
                                        viewModel.setRepleOn(viewModel
                                            .partnerCommentList[index].idx);
                                        FocusScope.of(context)
                                            .requestFocus(_commentFocusNode);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 45)),
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
                              child: CupertinoTextField(
                                controller: _commentController,
                                focusNode: _commentFocusNode,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                placeholder: "댓글을 남겨주세요.",
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (_commentController.text.isEmpty) {
                                    return;
                                  }
                                  if (viewModel.isRepleOn) {
                                    viewModel.postPartnerRepleComment(
                                        idx, _commentController.text);

                                    viewModel.setRepleOff();
                                  } else {
                                    viewModel.postPartnerComment(
                                        idx, _commentController.text);
                                    viewModel.setRepleOff();
                                  }
                                  _commentController.clear();
                                  FocusScope.of(context).unfocus();
                                },
                                icon: SvgPicture.asset(
                                  "assets/icons/send.svg",
                                )),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
                bottomNavigationBar: Visibility(
                  visible: viewModel.partnerDetailData.loginUserPartnerState,
                  child: BottomAppBar(
                    //하단 바
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 5),
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
        } else {
          return Container(
            color: Colors.white,
          );
        }
      },
    );
  }
}
