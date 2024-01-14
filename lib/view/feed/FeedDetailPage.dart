import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:winit/view/feed/AddFeedPage.dart';
import 'package:winit/view/widget/CustomDrawer.dart';
import 'package:winit/view/widget/FeedCommentBox.dart';
import 'package:winit/view/widget/MainAppBar.dart';

import '../account/SignInPage.dart';
import '../project/Register/RegisterPartnerPage.dart';
import '../project/Register/RegisterProjectPage.dart';
import '../widget/CommentBox.dart';
import '../widget/CustomDialogSelect.dart';
import 'FeedViewModel.dart';

class FeedDetailPage extends StatefulWidget {
  final int feedIdx;
  const FeedDetailPage({Key? key, required this.feedIdx}) : super(key: key);

  @override
  State<FeedDetailPage> createState() => _FeedDetailPageState();
}

class _FeedDetailPageState extends State<FeedDetailPage> {
  late int feedIdx;
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final controller = PageController(viewportFraction: 1.0, keepPage: true);

  Future<void> loadData() async {
    await Provider.of<FeedViewModel>(context, listen: false)
        .getFeedDetail(feedIdx);
    await Provider.of<FeedViewModel>(context, listen: false)
        .getFeedComment(feedIdx);
  }

  @override
  void initState() {
    super.initState();
    feedIdx = widget.feedIdx;
    Provider.of<FeedViewModel>(context, listen: false).setRepleOff();
  }

  @override
  Widget build(BuildContext context) {
    final mainContext = context;
    return FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<FeedViewModel>(
                builder: (context, viewModel, child) => MaterialApp(
                      home: Scaffold(
                        endDrawer: CustomDrawer(
                          onLogout: () {
                            showDialog(
                                context: context,
                                builder: (context) => CustomDialogSelect(
                                    title: "로그아웃",
                                    content: "로그아웃 하시겠습니까?",
                                    cancelText: "취소",
                                    confirmText: "확인",
                                    cancelPressed: () {
                                      Navigator.pop(context);
                                    },
                                    confirmPressed: () async {
                                      await storage.delete(key: "token");
                                      if (!mounted) return;
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const SignInPage()),
                                          (route) => false);
                                    }));
                          },
                          registerPartner: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPartnerPage()));
                          },
                          registerProject: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterProjectPage()));
                          },
                        ),
                        backgroundColor: Colors.white,
                        appBar: const MainAppBar(),
                        body: SafeArea(
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
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
                                                  const TextSpan(text: "제목: "),
                                                  TextSpan(
                                                      text: viewModel
                                                          .feedDetailData.title,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                ])),
                                            const Spacer(),
                                            Text(
                                              viewModel
                                                  .feedDetailData.createdAt,
                                              style:
                                                  const TextStyle(fontSize: 12),
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
                                                    color: Colors.black,
                                                    fontSize: 12),
                                                children: <TextSpan>[
                                              const TextSpan(text: "작성자: "),
                                              TextSpan(
                                                  text: viewModel.feedDetailData
                                                      .user.nickname,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                            ])),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        //피드 내용
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          viewModel.feedDetailData.contents,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Visibility(
                                        visible: viewModel
                                            .feedDetailData.imgList.isNotEmpty,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          height: 240,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: PageView.builder(
                                              itemCount: viewModel
                                                  .feedDetailData
                                                  .imgList
                                                  .length,
                                              itemBuilder: (_, index) {
                                                return Image.network(
                                                    viewModel.feedDetailData
                                                        .imgList[index],
                                                    fit: BoxFit.cover);
                                              },
                                              controller: controller,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: viewModel
                                            .feedDetailData.imgList.isNotEmpty,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          alignment: Alignment.center,
                                          child: SmoothPageIndicator(
                                              controller: controller,
                                              count: viewModel.feedDetailData
                                                      .imgList.isEmpty
                                                  ? 1
                                                  : viewModel.feedDetailData
                                                      .imgList.length,
                                              effect: const ScrollingDotsEffect(
                                                activeDotColor:
                                                    Color(0xff2D8DF4),
                                                activeStrokeWidth: 10,
                                                activeDotScale: 1.7,
                                                maxVisibleDots: 5,
                                                radius: 8,
                                                dotHeight: 5,
                                                dotWidth: 5,
                                              )),
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            viewModel.feedCommentList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 15),
                                              child: FeedCommentBox(
                                                name: viewModel
                                                    .feedCommentList[index]
                                                    .user
                                                    .nickname,
                                                date: viewModel
                                                    .feedCommentList[index]
                                                    .createdAt,
                                                comment: viewModel
                                                    .feedCommentList[index]
                                                    .contents,
                                                repleData: viewModel
                                                    .feedCommentList[index]
                                                    .replyCommentList,
                                                repleOnTap: () {
                                                  viewModel.setRepleOn(viewModel
                                                      .feedCommentList[index]
                                                      .idx);
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _commentFocusNode);
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(bottom: 45)),
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
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/img.png"),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        height: double.infinity,
                                        child: CupertinoTextField(
                                          controller: _commentController,
                                          focusNode: _commentFocusNode,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                          placeholder: "댓글을 남겨주세요.",
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: const BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            if (_commentController
                                                .text.isEmpty) {
                                              return;
                                            }
                                            if (viewModel.isRepleOn) {
                                              viewModel.postFeedRepleComment(
                                                  feedIdx,
                                                  _commentController.text);
                                              viewModel.setRepleOff();
                                            } else {
                                              viewModel.postFeedComment(feedIdx,
                                                  _commentController.text);
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
                            ],
                          ),
                        ),
                        bottomNavigationBar: Visibility(
                          visible: viewModel.feedDetailData.myFeedState,
                          child: BottomAppBar(
                            height: 45,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      iconSize: 45,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CustomDialogSelect(
                                                  title: "프로젝트 삭제",
                                                  content:
                                                      "삭제된 프로젝트는 복구할 수 없습니다.",
                                                  cancelText: "아니오",
                                                  confirmText: "예",
                                                  cancelPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  confirmPressed: () async {
                                                    await viewModel
                                                        .deleteFeed(feedIdx);
                                                    if (!mounted) return;
                                                    Navigator.pop(context);
                                                    Navigator.pop(
                                                        mainContext, true);
                                                  });
                                            });
                                      },
                                      icon: SvgPicture.asset(
                                        "assets/icons/trash.svg",
                                        height: 45,
                                      )),
                                  IconButton(
                                      iconSize: 45,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddFeedPage(
                                                      feedIdx: viewModel
                                                          .feedDetailData.idx,
                                                      previousData: viewModel
                                                          .feedDetailData,
                                                    ))).then((value) {
                                          if (value == true) {
                                            viewModel.getFeedDetail(feedIdx);
                                          }
                                        });
                                      },
                                      icon: SvgPicture.asset(
                                        "assets/icons/edit.svg",
                                        height: 45,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ));
          } else {
            return const CupertinoActivityIndicator();
          }
        });
  }
}
