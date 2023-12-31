import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:winit/network/model/ProjectDetailModel.dart';
import 'package:winit/view/widget/CustomDialogConfirm.dart';
import 'package:winit/view/widget/CustomLocalSelectBtn.dart';
import 'package:winit/view/widget/CustomRegionSelectBtn.dart';
import 'package:winit/view/widget/CustomTextFieldGray.dart';
import 'package:winit/view/widget/RegisterAppBar.dart';
import 'package:winit/view/widget/UploadImageBox.dart';
import 'package:winit/view/widget/SearchAppBar.dart';
import 'package:winit/view/widget/CustomCheckboxTile.dart';
import 'package:winit/view/project/Register/AddViewModel.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../../widget/CustomDialogSelect.dart';

class RegisterProjectPage extends StatefulWidget {
  final int? projectIdx;
  final ProjectDetailModel? previousData;
  const RegisterProjectPage({Key? key, this.projectIdx, this.previousData})
      : super(key: key);

  @override
  State<RegisterProjectPage> createState() => _RegisterProjectPageState();
}

class _RegisterProjectPageState extends State<RegisterProjectPage> {
  late int? projectIdx;
  late ProjectDetailModel? previousData;
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _functionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _startYearController = TextEditingController();
  final TextEditingController _startMonthController = TextEditingController();
  final TextEditingController _startDayController = TextEditingController();
  final TextEditingController _endYearController = TextEditingController();
  final TextEditingController _endMonthController = TextEditingController();
  final TextEditingController _endDayController = TextEditingController();
  late var startTimeUTC;
  late var endTimeUTC;

  Future<void> loadData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddViewModel>(context, listen: false).initData();
    });
    await Provider.of<AddViewModel>(context, listen: false).getArea1();
    await Provider.of<AddViewModel>(context, listen: false).getProjectField();
    final previousData = this.previousData;

    if (previousData != null) {
      Provider.of<AddViewModel>(context, listen: false)
          .setPreviousProjectData(previousData);
      _workController.text = previousData.method;
      _functionController.text = previousData.demandSkill;
      _amountController.text = previousData.amount;
      _startYearController.text = previousData.startTime.split("-")[0];
      _startMonthController.text = previousData.startTime.split("-")[1];
      _startDayController.text = previousData.startTime.split("-")[2];
      _endYearController.text = previousData.endTime.split("-")[0];
      _endMonthController.text = previousData.endTime.split("-")[1];
      _endDayController.text = previousData.endTime.split("-")[2];
      print(previousData.startTime);
      //2023-12-31 형식을 2023-12-31T15:00:00.000Z 형식으로 바꿔줌
      startTimeUTC = "${previousData.startTime}T15:00:00";
      endTimeUTC = "${previousData.endTime}T15:00:00";
    }
  }

  @override
  void initState() {
    super.initState();
    print("RegisterProjectPage");
    projectIdx = widget.projectIdx;
    previousData = widget.previousData;
  }

  @override
  Widget build(BuildContext context) {
    final mainContext = context;
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<AddViewModel>(
            builder: (context, viewModel, child) => Stack(
              children: [
                MaterialApp(
                  home: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: const RegisterAppBar(title: "프로젝트 등록"),
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 23),
                            child: Column(children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "작업기간",
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
                              const Padding(padding: EdgeInsets.only(top: 22)),
                              Row(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10)),
                                  const Text(
                                    "시작일",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.1),
                                    width: MediaQuery.of(context).size.width *
                                        0.27,
                                    height: 40,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        selectDateAndPrintTime(context, true);
                                      },
                                      child: IgnorePointer(
                                        child: CustomTextFieldGray(
                                            hintText: "년",
                                            obscureText: false,
                                            controller: _startYearController,
                                            keyboardType: TextInputType.number,
                                            textFontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    width: MediaQuery.of(context).size.width *
                                        0.18,
                                    height: 40,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        selectDateAndPrintTime(context, true);
                                      },
                                      child: IgnorePointer(
                                        child: CustomTextFieldGray(
                                            hintText: "월",
                                            obscureText: false,
                                            controller: _startMonthController,
                                            keyboardType: TextInputType.number,
                                            textFontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    width: MediaQuery.of(context).size.width *
                                        0.18,
                                    height: 40,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        selectDateAndPrintTime(context, true);
                                      },
                                      child: IgnorePointer(
                                        child: CustomTextFieldGray(
                                            hintText: "일",
                                            obscureText: false,
                                            controller: _startDayController,
                                            keyboardType: TextInputType.number,
                                            textFontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(left: 10)),
                                  const Text(
                                    "종료일",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.1),
                                    width: MediaQuery.of(context).size.width *
                                        0.27,
                                    height: 40,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        selectDateAndPrintTime(context, false);
                                      },
                                      child: IgnorePointer(
                                        child: CustomTextFieldGray(
                                            hintText: "년",
                                            obscureText: false,
                                            controller: _endYearController,
                                            keyboardType: TextInputType.number,
                                            textFontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    width: MediaQuery.of(context).size.width *
                                        0.18,
                                    height: 40,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        selectDateAndPrintTime(context, false);
                                      },
                                      child: IgnorePointer(
                                        child: CustomTextFieldGray(
                                            hintText: "월",
                                            obscureText: false,
                                            controller: _endMonthController,
                                            keyboardType: TextInputType.number,
                                            textFontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    width: MediaQuery.of(context).size.width *
                                        0.18,
                                    height: 40,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        selectDateAndPrintTime(context, false);
                                      },
                                      child: IgnorePointer(
                                        child: CustomTextFieldGray(
                                            hintText: "일",
                                            obscureText: false,
                                            controller: _endDayController,
                                            keyboardType: TextInputType.number,
                                            textFontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.only(top: 33)),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "방식",
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
                                  itemCount: viewModel.methodList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 5 / 1,
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      child: CustomCheckboxTile(
                                        item: viewModel.methodList[index],
                                        onTap: () =>
                                            viewModel.toggleMethodBtn(index),
                                      ),
                                    );
                                  }),
                              const Padding(padding: EdgeInsets.only(top: 20)),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "파트너 분야",
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
                                  itemCount: viewModel.projectFieldList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 5 / 1,
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      child: CustomCheckboxTile(
                                        item: viewModel.projectFieldList[index],
                                        onTap: () => viewModel
                                            .toggleProjectFieldCheckbox(index),
                                      ),
                                    );
                                  }),
                              const Padding(padding: EdgeInsets.only(top: 20)),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "지역선택",
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
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: viewModel.area1List.length,
                                          //아이템간의 간격을 조절하는 코드
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              margin:
                                                  const EdgeInsets.only(top: 2),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.085,
                                              child: CustomLocalSelectBtn(
                                                local:
                                                    viewModel.area1List[index],
                                                onTap: () => viewModel
                                                    .toggleLocalBtn(index),
                                              ),
                                            );
                                          }),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 2)),
                                    Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: viewModel.area2List.length,
                                          //아이템간의 간격을 조절하는 코드
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              margin:
                                                  const EdgeInsets.only(top: 2),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.085,
                                              child: CustomRegionSelectBtn(
                                                region:
                                                    viewModel.area2List[index],
                                                onTap: () => viewModel
                                                    .toggleRegionBtn(index),
                                              ),
                                            );
                                          }),
                                    ),
                                  ]),
                              const Padding(padding: EdgeInsets.only(top: 33)),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "업무방식",
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
                                    hintText: "업무방식을 입력해주세요.",
                                    obscureText: false,
                                    controller: _workController,
                                    keyboardType: TextInputType.text,
                                    textFontSize: 12),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 33)),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "요구기능",
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
                                    hintText: "요구기능을 입력해주세요.",
                                    obscureText: false,
                                    controller: _functionController,
                                    keyboardType: TextInputType.text,
                                    textFontSize: 12),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 33)),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "공사금액",
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
                                    hintText: "공사금액 입력해주세요.",
                                    obscureText: false,
                                    controller: _amountController,
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
                                  if (_startYearController.text.isEmpty ||
                                      _startMonthController.text.isEmpty ||
                                      _startDayController.text.isEmpty ||
                                      _endYearController.text.isEmpty ||
                                      _endMonthController.text.isEmpty ||
                                      _endDayController.text.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogConfirm(
                                            title: "주의",
                                            content: "작업기간을 입력해주세요.",
                                            confirmText: "확인",
                                            confirmPressed: () {
                                              Navigator.pop(context);
                                            },
                                          );
                                        });
                                  } else if (viewModel.getSelectedMethod() ==
                                      null) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogConfirm(
                                            title: "주의",
                                            content: "방식을 선택해주세요.",
                                            confirmText: "확인",
                                            confirmPressed: () {
                                              Navigator.pop(context);
                                            },
                                          );
                                        });
                                  } else if (viewModel
                                      .getSelectedProjectField()
                                      .isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogConfirm(
                                            title: "주의",
                                            content: "파트너 분야를 선택해주세요.",
                                            confirmText: "확인",
                                            confirmPressed: () {
                                              Navigator.pop(context);
                                            },
                                          );
                                        });
                                  } else if (viewModel.getSelectedArea() ==
                                      null) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogConfirm(
                                            title: "주의",
                                            content: "지역을 선택해주세요.",
                                            confirmText: "확인",
                                            confirmPressed: () {
                                              Navigator.pop(context);
                                            },
                                          );
                                        });
                                  } else if (_workController.text.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogConfirm(
                                            title: "주의",
                                            content: "업무방식을 입력해주세요.",
                                            confirmText: "확인",
                                            confirmPressed: () {
                                              Navigator.pop(context);
                                            },
                                          );
                                        });
                                  } else if (_functionController.text.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogConfirm(
                                            title: "주의",
                                            content: "요구기능을 입력해주세요.",
                                            confirmText: "확인",
                                            confirmPressed: () {
                                              Navigator.pop(context);
                                            },
                                          );
                                        });
                                  } else if (_amountController.text.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogConfirm(
                                            title: "주의",
                                            content: "공사금액을 입력해주세요.",
                                            confirmText: "확인",
                                            confirmPressed: () {
                                              Navigator.pop(context);
                                            },
                                          );
                                        });
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CustomDialogSelect(
                                                title: "등록하기",
                                                content: "등록 하시겠습니까?",
                                                cancelText: "취소",
                                                confirmText: "확인",
                                                cancelPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                confirmPressed: () async {
                                                  if (projectIdx == null) {
                                                    await viewModel
                                                        .registerProject(
                                                            startTimeUTC,
                                                            endTimeUTC,
                                                            _workController
                                                                .text,
                                                            _functionController
                                                                .text,
                                                            _amountController
                                                                .text);
                                                  } else {
                                                    await viewModel.editProject(
                                                        projectIdx!,
                                                        startTimeUTC,
                                                        endTimeUTC,
                                                        _workController.text,
                                                        _functionController
                                                            .text,
                                                        _amountController.text);
                                                  }
                                                  if (!mounted) return;
                                                  Navigator.pop(context);

                                                  if (viewModel
                                                      .isRegisterSuccess) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return CustomDialogConfirm(
                                                            title: "성공",
                                                            content:
                                                                "등록이 완료되었습니다.",
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
                                                        builder: (BuildContext
                                                            context) {
                                                          return CustomDialogConfirm(
                                                            title: "실패",
                                                            content:
                                                                "등록에 실패하였습니다.",
                                                            confirmText: "확인",
                                                            confirmPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          );
                                                        });
                                                  }
                                                }));
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
                ),
                if (viewModel.isLoading)
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
          return Container(
            color: Colors.white,
          );
        }
      },
    );
  }

  Future<void> selectDateAndPrintTime(
      BuildContext context, bool isStart) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    String convertToUTCString(DateTime date) {
      tz.initializeTimeZones();
      final location = tz.getLocation('Asia/Seoul');
      final tz.TZDateTime tzDateTime =
          tz.TZDateTime(location, date.year, date.month, date.day);

      // 변환된 tz.TZDateTime을 UTC로 변환
      DateTime utcDateTime = tzDateTime.toUtc();

      // UTC 시간을 ISO 8601 형식으로 변환
      return DateFormat("yyyy-MM-dd'T'HH:mm:ss'").format(utcDateTime);
    }

    if (pickedDate != null) {
      final String formattedDateTime = convertToUTCString(pickedDate);
      print(formattedDateTime);
      if (isStart) {
        startTimeUTC = formattedDateTime;
        _startYearController.text = pickedDate.year.toString();
        _startMonthController.text = pickedDate.month.toString();
        _startDayController.text = pickedDate.day.toString();
      } else {
        endTimeUTC = formattedDateTime;
        _endYearController.text = pickedDate.year.toString();
        _endMonthController.text = pickedDate.month.toString();
        _endDayController.text = pickedDate.day.toString();
      }
    }
  }
}
