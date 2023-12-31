import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:winit/view/project/Detail/DetailViewModel.dart';
import 'package:winit/view/project/Register/RegisterProjectPage.dart';
import 'package:winit/view/widget/CommentBox.dart';
import 'package:winit/view/widget/CustomDialogSelect.dart';
import 'package:winit/view/widget/MainAppBar.dart';

import '../../account/SignInPage.dart';
import '../../widget/CustomDrawer.dart';
import '../Register/RegisterPartnerPage.dart';

class DetailProjectPage extends StatefulWidget {
  final int idx;
  const DetailProjectPage({required this.idx, Key? key}) : super(key: key);

  @override
  State<DetailProjectPage> createState() => _DetailProjectPageState();
}

class _DetailProjectPageState extends State<DetailProjectPage> {
  late int idx;
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> loadData() async {
    await Provider.of<DetailViewModel>(context, listen: false)
        .getProjectDetail(idx);
    await Provider.of<DetailViewModel>(context, listen: false)
        .getProjectComment(idx);
  }

  @override
  void initState() {
    super.initState();
    idx = widget.idx;
    Provider.of<DetailViewModel>(context, listen: false).setRepleOff();
  }

  @override
  void deactivate() {
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
                                                .projectDetailData.User.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                      ])),
                                  const Spacer(),
                                  Text(
                                    viewModel.projectDetailData.createdAt,
                                    style: const TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 5)),
                            Row(
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 12),
                                        children: <TextSpan>[
                                      const TextSpan(text: "시작일: "),
                                      TextSpan(
                                          text: viewModel
                                              .projectDetailData.startTime,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ])),
                                const Padding(
                                    padding: EdgeInsets.only(left: 10)),
                                RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 12),
                                        children: <TextSpan>[
                                      const TextSpan(text: "종료일: "),
                                      TextSpan(
                                          text: viewModel
                                              .projectDetailData.endTime,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ])),
                              ],
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
                                        text: viewModel.projectRegion,
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
                                    const TextSpan(text: "요구 기능: "),
                                    TextSpan(
                                        text: viewModel
                                            .projectDetailData.demandSkill,
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
                                            viewModel.projectDetailData.method,
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
                                    const TextSpan(text: "지급 방식: "),
                                    TextSpan(
                                        text: viewModel.projectDetailData
                                                    .methodType ==
                                                1
                                            ? "기간제"
                                            : "도급제",
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
                                    const TextSpan(text: "분야: "),
                                    TextSpan(
                                        text: viewModel.projectField,
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
                            Visibility(
                              visible: viewModel
                                  .projectDetailData.ProjectImg.isNotEmpty,
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                height: 240,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: PageView.builder(
                                    itemCount: viewModel
                                        .projectDetailData.ProjectImg.length,
                                    itemBuilder: (_, index) {
                                      return Image.network(
                                          viewModel.projectDetailData
                                              .ProjectImg[index].imgPath,
                                          fit: BoxFit.cover);
                                    },
                                    controller: controller,
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: viewModel
                                  .projectDetailData.ProjectImg.isNotEmpty,
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                child: SmoothPageIndicator(
                                    controller: controller,
                                    count: viewModel.projectDetailData
                                            .ProjectImg.isEmpty
                                        ? 1
                                        : viewModel.projectDetailData.ProjectImg
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
                              itemCount: viewModel.projectCommentList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    child: CommentBox(
                                      name: viewModel.projectCommentList[index]
                                          .User.nickname,
                                      date: viewModel
                                          .projectCommentList[index].createdAt,
                                      comment: viewModel
                                          .projectCommentList[index].contents,
                                      repleData: viewModel
                                          .projectCommentList[index]
                                          .ProjectReplyComment,
                                      repleOnTap: () {
                                        viewModel.setRepleOn(viewModel
                                            .projectCommentList[index].idx);
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
                                    viewModel.postProjectRepleComment(
                                        idx, _commentController.text);

                                    viewModel.setRepleOff();
                                  } else {
                                    viewModel.postProjectComment(
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
                  visible: viewModel.projectDetailData.loginUserProjectState,
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
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CustomDialogSelect(
                                                  title: "프로젝트 삭제",
                                                  content: "프로젝트를 삭제하시겠습니까?",
                                                  cancelText: "아니오",
                                                  confirmText: "예",
                                                  cancelPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  confirmPressed: () async {
                                                    await viewModel
                                                        .deleteProject(idx);
                                                    if (!mounted) return;
                                                    Navigator.pop(context);
                                                    Navigator.pop(
                                                        mainContext, true);
                                                  });
                                            });
                                      },
                                      icon: SvgPicture.asset(
                                        "assets/icons/trash.svg",
                                        height: 50,
                                      )),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterProjectPage(
                                                  projectIdx: viewModel
                                                      .projectDetailData.idx,
                                                  previousData: viewModel
                                                      .projectDetailData,
                                                ))).then((value) {
                                      if (value == true) {
                                        viewModel.getProjectDetail(idx);
                                      }
                                    });
                                  },
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
