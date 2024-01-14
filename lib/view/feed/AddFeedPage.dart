import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/network/model/FeedDetailModel.dart';
import 'package:winit/view/feed/FeedViewModel.dart';
import 'package:winit/view/widget/CustomDialogSelect.dart';
import 'package:winit/view/widget/RegisterAppBar.dart';
import 'package:winit/view/widget/TitleOnlyAppBar.dart';

import '../widget/CustomDialogConfirm.dart';
import '../widget/CustomTextFieldGray.dart';
import '../widget/UploadImageBox.dart';

class AddFeedPage extends StatefulWidget {
  final int? feedIdx;
  final FeedDetailModel? previousData;
  const AddFeedPage({Key? key, this.feedIdx, this.previousData})
      : super(key: key);

  @override
  State<AddFeedPage> createState() => _AddFeedPageState();
}

class _AddFeedPageState extends State<AddFeedPage> {
  late int? feedIdx;
  late FeedDetailModel? previousData;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentsController = TextEditingController();

  Future<void> loadData() async {
    await Provider.of<FeedViewModel>(context, listen: false).addInit();
    feedIdx = widget.feedIdx;
    previousData = widget.previousData;
    previousData ??= FeedDetailModel(
        idx: 0,
        title: '',
        contents: '',
        imgList: [],
        createdAt: '',
        myFeedState: false,
        user: UserModel(idx: 0, nickname: ''));
    _titleController.text = previousData!.title;
    _contentsController.text = previousData!.contents;
  }

  @override
  Widget build(BuildContext context) {
    final mainContext = context;
    return FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<FeedViewModel>(
              builder: (context, viewModel, child) => Stack(
                children: [
                  Scaffold(
                    backgroundColor: Colors.white,
                    appBar: TitleOnlyAppBar(
                      title: '피드 작성',
                    ),
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 23),
                            child: Column(children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "제목",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                //구분선
                                margin: const EdgeInsets.only(top: 13),
                                height: 1,
                                color: const Color(0xffECECEC),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 13),
                                height: 80,
                                child: CustomTextFieldGray(
                                    hintText: "제목을 입력해주세요.",
                                    obscureText: false,
                                    controller: _titleController,
                                    keyboardType: TextInputType.text,
                                    textFontSize: 12),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 33)),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "내용",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                //구분선
                                margin: const EdgeInsets.only(top: 13),
                                height: 1,
                                color: const Color(0xffECECEC),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 13),
                                height: 140,
                                child: CustomTextFieldGray(
                                    hintText: "내용 입력해주세요.",
                                    obscureText: false,
                                    controller: _contentsController,
                                    keyboardType: TextInputType.text,
                                    textFontSize: 12),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 33)),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "사진 등록",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                //구분선
                                margin: const EdgeInsets.only(top: 13),
                                height: 1,
                                color: const Color(0xffECECEC),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 13)),
                              GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: viewModel.imgList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 1 / 1,
                                          crossAxisCount: 5,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 20),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.1,
                                      child: UploadImageBox(
                                        image: viewModel.imgList[index],
                                        onTap: () async {
                                          if (index == 0) {
                                            await viewModel.pickImg();
                                            if (!mounted) return;
                                            if (!viewModel
                                                .isImageUploadSuccess) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      CustomDialogConfirm(
                                                          title: "주의",
                                                          content:
                                                              "이미지 용량이 너무 큽니다.",
                                                          confirmText: "확인",
                                                          confirmPressed: () {
                                                            viewModel
                                                                .setIsImageUploadSuccess(
                                                                    true);
                                                            Navigator.pop(
                                                                context);
                                                          }));
                                            }
                                          } else {
                                            viewModel.removeImg(index);
                                          }
                                        },
                                      ),
                                    );
                                  }),
                              const Padding(padding: EdgeInsets.only(top: 33)),
                            ])),
                      ),
                    ),
                    bottomNavigationBar: BottomAppBar(
                      height: 70,
                      padding: const EdgeInsets.all(0),
                      color: const Color(0x00000000),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 0),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(
                              color: Color(0xFFA8B0B8),
                              width: 0.5,
                            ))),
                        margin: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: SvgPicture.asset(
                                  "assets/icons/cancel.svg",
                                  height: 30,
                                )),
                            IconButton(
                                onPressed: () {
                                  if (_titleController.text.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogConfirm(
                                            title: "주의",
                                            content: "제목을 입력해주세요.",
                                            confirmText: "확인",
                                            confirmPressed: () {
                                              Navigator.pop(context);
                                            },
                                          );
                                        });
                                  } else if (_contentsController.text.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogConfirm(
                                            title: "주의",
                                            content: "내용을 입력해주세요.",
                                            confirmText: "확인",
                                            confirmPressed: () {
                                              Navigator.pop(context);
                                            },
                                          );
                                        });
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogSelect(
                                            title: "등록하기",
                                            content: "피드를 등록하시겠습니까?",
                                            confirmText: "확인",
                                            cancelText: "취소",
                                            cancelPressed: () {
                                              Navigator.pop(context);
                                            },
                                            confirmPressed: () async {
                                              if (feedIdx == null) {
                                                await viewModel.addFeed(
                                                    _titleController.text,
                                                    _contentsController.text);
                                              } else {
                                                await viewModel.editFeed(
                                                    feedIdx!,
                                                    _titleController.text,
                                                    _contentsController.text);
                                              }
                                              if (!mounted) return;
                                              Navigator.pop(context);
                                              if (viewModel.isAddSuccess) {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return CustomDialogConfirm(
                                                        title: "성공",
                                                        content: "등록이 완료되었습니다.",
                                                        confirmText: "확인",
                                                        confirmPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              mainContext,
                                                              true);
                                                        },
                                                      );
                                                    });
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return CustomDialogConfirm(
                                                        title: "실패",
                                                        content: "등록에 실패하였습니다.",
                                                        confirmText: "확인",
                                                        confirmPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      );
                                                    });
                                              }
                                            },
                                          );
                                        });
                                  }
                                },
                                icon: SvgPicture.asset(
                                  "assets/icons/check.svg",
                                  height: 30,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (viewModel.isImgLoading)
                    AbsorbPointer(
                      absorbing: true,
                      child: Container(
                          color: Colors.black.withOpacity(0.5),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xff2D8DF4),
                            ),
                          )),
                    )
                ],
              ),
            );
          } else {
            return const CupertinoActivityIndicator();
          }
        });
  }
}
