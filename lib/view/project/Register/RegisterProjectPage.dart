import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/widget/CustomLocalSelectBtn.dart';
import 'package:winit/view/widget/CustomRegionSelectBtn.dart';
import 'package:winit/view/widget/CustomTextFieldGray.dart';
import 'package:winit/view/widget/UploadImageBox.dart';
import 'package:winit/view/widget/SearchAppBar.dart';
import 'package:winit/view/widget/CustomCheckboxTile.dart';
import 'package:winit/view/project/Register/AddViewModel.dart';

class RegisterProjectPage extends StatefulWidget {
  const RegisterProjectPage({Key? key}) : super(key: key);

  @override
  State<RegisterProjectPage> createState() => _RegisterProjectPageState();
}

class _RegisterProjectPageState extends State<RegisterProjectPage> {
  final TextEditingController _periodController = TextEditingController();
  final TextEditingController _partnerAreaController = TextEditingController();
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _functionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddViewModel(),
      child: Consumer<AddViewModel>(
        builder: (context, viewModel, child) => Stack(
          children: [
            MaterialApp(
              home: Scaffold(
                backgroundColor: Colors.white,
                appBar: const SearchAppBar(title: "프로젝트 등록"),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 23),
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
                              const Padding(padding: EdgeInsets.only(left: 10)),
                              const Text(
                                "시작일",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.1),
                                width: MediaQuery.of(context).size.width * 0.27,
                                height: 40,
                                child: CustomTextFieldGray(
                                    hintText: "년",
                                    obscureText: false,
                                    controller: _periodController,
                                    keyboardType: TextInputType.number,
                                    textFontSize: 12),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                width: MediaQuery.of(context).size.width * 0.18,
                                height: 40,
                                child: CustomTextFieldGray(
                                    hintText: "월",
                                    obscureText: false,
                                    controller: _periodController,
                                    keyboardType: TextInputType.number,
                                    textFontSize: 12),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                width: MediaQuery.of(context).size.width * 0.18,
                                height: 40,
                                child: CustomTextFieldGray(
                                    hintText: "일",
                                    obscureText: false,
                                    controller: _periodController,
                                    keyboardType: TextInputType.number,
                                    textFontSize: 12),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Row(
                            children: [
                              Padding(padding: const EdgeInsets.only(left: 10)),
                              Text(
                                "종료일",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.1),
                                width: MediaQuery.of(context).size.width * 0.27,
                                height: 40,
                                child: CustomTextFieldGray(
                                    hintText: "년",
                                    obscureText: false,
                                    controller: _periodController,
                                    keyboardType: TextInputType.number,
                                    textFontSize: 12),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                width: MediaQuery.of(context).size.width * 0.18,
                                height: 40,
                                child: CustomTextFieldGray(
                                    hintText: "월",
                                    obscureText: false,
                                    controller: _periodController,
                                    keyboardType: TextInputType.number,
                                    textFontSize: 12),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                width: MediaQuery.of(context).size.width * 0.18,
                                height: 40,
                                child: CustomTextFieldGray(
                                    hintText: "일",
                                    obscureText: false,
                                    controller: _periodController,
                                    keyboardType: TextInputType.number,
                                    textFontSize: 12),
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
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  child: CustomCheckboxTile(
                                    item: viewModel.partnerFieldList[index],
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
                              itemCount: viewModel.partnerFieldList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 5 / 1,
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 10),
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  child: CustomCheckboxTile(
                                    item: viewModel.partnerFieldList[index],
                                    onTap: () =>
                                        viewModel.toggleFieldCheckbox(index),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: viewModel.area1List.length,
                                      //아이템간의 간격을 조절하는 코드
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          margin: const EdgeInsets.only(top: 2),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.085,
                                          child: CustomLocalSelectBtn(
                                            local: viewModel.area1List[index],
                                            onTap: () =>
                                                viewModel.toggleLocalBtn(index),
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
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          margin: const EdgeInsets.only(top: 2),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.085,
                                          child: CustomRegionSelectBtn(
                                            region: viewModel.area2List[index],
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
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  height:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: UploadImageBox(
                                    image: viewModel.imgList[index],
                                    onTap: () {
                                      if (index == 0) {
                                        viewModel.addImg();
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
                            onPressed: () {},
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
      ),
    );
  }
}