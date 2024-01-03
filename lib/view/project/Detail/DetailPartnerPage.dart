import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:winit/view/project/Register/RegisterPartnerPage.dart';
import 'package:winit/view/widget/CustomDrawer.dart';

import '../../account/SignInPage.dart';
import '../../widget/CommentBox.dart';
import '../../widget/CustomDialogSelect.dart';
import '../../widget/ImageBox.dart';
import '../../widget/MainAppBar.dart';
import '../Register/RegisterProjectPage.dart';
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
  final FlutterSecureStorage storage = const FlutterSecureStorage();

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
    Provider.of<DetailViewModel>(context, listen: false).setRepleOff();
  }

  @override
  void deactivate() {
    _commentFocusNode.unfocus();
    super.deactivate();
  }

  final controller = PageController(viewportFraction: 1.0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final mainContext = context;
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<DetailViewModel>(
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
                            builder: (context) => const RegisterPartnerPage()));
                  },
                  registerProject: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterProjectPage()));
                  },
                ),
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
                                    const TextSpan(text: "경력: "),
                                    TextSpan(
                                        text:
                                            viewModel.partnerDetailData.career,
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
                                viewModel.partnerDetailData.method,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Visibility(
                              visible: viewModel
                                  .partnerDetailData.PartnerImg.isNotEmpty,
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                height: 240,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: PageView.builder(
                                    itemCount: viewModel
                                        .partnerDetailData.PartnerImg.length,
                                    itemBuilder: (_, index) {
                                      return Image.network(
                                          viewModel.partnerDetailData
                                              .PartnerImg[index].img,
                                          fit: BoxFit.cover);
                                    },
                                    controller: controller,
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: viewModel
                                  .partnerDetailData.PartnerImg.isNotEmpty,
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                child: SmoothPageIndicator(
                                    controller: controller,
                                    count: viewModel.partnerDetailData
                                            .PartnerImg.isEmpty
                                        ? 1
                                        : viewModel.partnerDetailData.PartnerImg
                                            .length,
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
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              iconSize: 55,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialogSelect(
                                          title: "삭제하시겠습니까?",
                                          content: "삭제된 프로젝트는 복구할 수 없습니다.",
                                          cancelText: "취소",
                                          confirmText: "확인",
                                          cancelPressed: () {
                                            Navigator.pop(context);
                                          },
                                          confirmPressed: () async {
                                            await viewModel.deletePartner(idx);
                                            if (!mounted) return;
                                            Navigator.pop(context);
                                            Navigator.pop(mainContext, true);
                                          });
                                    });
                              },
                              icon: SvgPicture.asset(
                                "assets/icons/trash.svg",
                                height: 55,
                              )),
                          IconButton(
                              iconSize: 45,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterPartnerPage(
                                              partnerIdx: viewModel
                                                  .partnerDetailData.idx,
                                              previousData:
                                                  viewModel.partnerDetailData,
                                            ))).then((value) {
                                  if (value == true) {
                                    viewModel.getPartnerDetail(idx);
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
