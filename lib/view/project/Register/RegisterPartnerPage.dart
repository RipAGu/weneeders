import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/network/model/PartnerDetailModel.dart';
import 'package:winit/view/widget/CustomDialogConfirm.dart';
import 'package:winit/view/widget/CustomDialogSelect.dart';
import 'package:winit/view/widget/CustomLocalSelectBtn.dart';
import 'package:winit/view/widget/CustomRegionSelectBtn.dart';
import 'package:winit/view/widget/CustomTextFieldGray.dart';
import 'package:winit/view/widget/RegisterAppBar.dart';
import 'package:winit/view/widget/UploadImageBox.dart';
import 'package:winit/view/widget/SearchAppBar.dart';
import '../../widget/CustomCheckboxTile.dart';
import 'AddViewModel.dart';

class RegisterPartnerPage extends StatefulWidget {
  final int? partnerIdx;
  final PartnerDetailModel? previousData;
  const RegisterPartnerPage({Key? key, this.previousData, this.partnerIdx})
      : super(key: key);

  @override
  State<RegisterPartnerPage> createState() => _RegisterPartnerPageState();
}

class _RegisterPartnerPageState extends State<RegisterPartnerPage> {
  late int? partnerIdx;
  late PartnerDetailModel? previousData;
  final TextEditingController _careerController = TextEditingController();
  final TextEditingController _workController = TextEditingController();

  Future<void> loadData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddViewModel>(context, listen: false).initData();
    });
    await Provider.of<AddViewModel>(context, listen: false).getPartnerField();
    await Provider.of<AddViewModel>(context, listen: false).getPartnerSkill();
    await Provider.of<AddViewModel>(context, listen: false).getArea1();
    final previousData = this.previousData;
    if (previousData != null) {
      Provider.of<AddViewModel>(context, listen: false)
          .setPreviousPartnerData(previousData);
      _careerController.text = previousData.career;
      _workController.text = previousData.method;
    }
  }

  @override
  void initState() {
    super.initState();
    partnerIdx = widget.partnerIdx;
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
                    appBar: const RegisterAppBar(title: "파트너 등록"),
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 23),
                            child: Column(children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "경력",
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
                                height: 40,
                                child: CustomTextFieldGray(
                                  hintText: "경력을 입력해주세요.",
                                  controller: _careerController,
                                  textFontSize: 12,
                                  keyboardType: TextInputType.text,
                                  obscureText: false,
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 33)),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "전문분야",
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
                                  itemCount: viewModel.partnerFieldList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 5 / 1,
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 10),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      child: CustomCheckboxTile(
                                        item: viewModel.partnerFieldList[index],
                                        onTap: () => viewModel
                                            .toggleFieldCheckbox(index),
                                      ),
                                    );
                                  }),
                              const Padding(padding: EdgeInsets.only(top: 33)),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "사용기술",
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
                              Padding(padding: const EdgeInsets.only(top: 13)),
                              GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: viewModel.partnerSkillList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 6 / 1,
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 5),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CustomCheckboxTile(
                                      item: viewModel.partnerSkillList[index],
                                      onTap: () =>
                                          viewModel.toggleTechCheckbox(index),
                                    );
                                  }),
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
                              const Padding(padding: EdgeInsets.only(top: 13)),
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
                                  "포트폴리오 등록",
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
                                  if (_careerController.text.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CustomDialogConfirm(
                                                title: "주의",
                                                content: "경력을 입력해주세요.",
                                                confirmText: "확인",
                                                confirmPressed: () {
                                                  Navigator.pop(context);
                                                }));
                                  } else if (viewModel
                                      .getSelectedField()
                                      .isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CustomDialogConfirm(
                                                title: "주의",
                                                content: "전문분야를 선택해주세요.",
                                                confirmText: "확인",
                                                confirmPressed: () {
                                                  Navigator.pop(context);
                                                }));
                                  } else if (viewModel
                                      .getSelectedSkill()
                                      .isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CustomDialogConfirm(
                                                title: "주의",
                                                content: "사용기술을 선택해주세요.",
                                                confirmText: "확인",
                                                confirmPressed: () {
                                                  Navigator.pop(context);
                                                }));
                                  } else if (_workController.text.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CustomDialogConfirm(
                                                title: "주의",
                                                content: "업무방식을 입력해주세요.",
                                                confirmText: "확인",
                                                confirmPressed: () {
                                                  Navigator.pop(context);
                                                }));
                                  } else if (viewModel.getSelectedArea() ==
                                      null) {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CustomDialogConfirm(
                                                title: "주의",
                                                content: "지역을 선택해주세요.",
                                                confirmText: "확인",
                                                confirmPressed: () {
                                                  Navigator.pop(context);
                                                }));
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
                                                  if (partnerIdx == null) {
                                                    await viewModel
                                                        .registerPartner(
                                                            _careerController
                                                                .text,
                                                            _workController
                                                                .text);
                                                  } else {
                                                    await viewModel.editPartner(
                                                      partnerIdx!,
                                                      _careerController.text,
                                                      _workController.text,
                                                    );
                                                  }
                                                  if (!mounted) return;
                                                  Navigator.pop(context);
                                                  if (viewModel
                                                      .isRegisterSuccess) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            CustomDialogConfirm(
                                                                title: "등록완료",
                                                                content:
                                                                    "파트너 등록이 완료되었습니다.",
                                                                confirmText:
                                                                    "확인",
                                                                confirmPressed:
                                                                    () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  Navigator.pop(
                                                                      mainContext,
                                                                      true);
                                                                }));
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            CustomDialogConfirm(
                                                                title: "등록실패",
                                                                content:
                                                                    "파트너 등록에 실패하였습니다.",
                                                                confirmText:
                                                                    "확인",
                                                                confirmPressed:
                                                                    () {
                                                                  Navigator.pop(
                                                                    context,
                                                                  );
                                                                }));
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
}
