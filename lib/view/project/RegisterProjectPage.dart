import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/widget/CustomLocalSelectBtn.dart';
import 'package:winit/view/widget/CustomRegionSelectBtn.dart';
import 'package:winit/view/widget/CustomTextField.dart';
import 'package:winit/view/widget/CustomTextFieldGray.dart';
import 'package:winit/view/widget/ImageBox.dart';
import 'package:winit/view/widget/SearchAppBar.dart';
import '../widget/CustomCheckboxTile.dart';
import 'AddViewModel.dart';

class RegisterProjectPage extends StatefulWidget {
  const RegisterProjectPage({Key? key}) : super(key: key);

  @override
  State<RegisterProjectPage> createState() => _RegisterProjectPageState();
}

class _RegisterProjectPageState extends State<RegisterProjectPage> {
  final TextEditingController _careerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddViewModel(),
      child: Consumer<AddViewModel>(
        builder: (context, viewModel, child) => MaterialApp(
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
                                item: viewModel.methodList[index],
                                onTap: () => viewModel.toggleMethodBtn(index),
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
                          itemCount: viewModel.testList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 5 / 1,
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10),
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              child: CustomCheckboxTile(
                                item: viewModel.testList[index],
                                onTap: () =>
                                    viewModel.toggleFieldCheckbox(index),
                              ),
                            );
                          }),
                      Container(
                        margin: const EdgeInsets.only(top: 13),
                        height: 40,
                        child: CustomTextFieldGray(
                            hintText: "직접입력",
                            obscureText: false,
                            controller: _careerController,
                            keyboardType: TextInputType.text,
                            textFontSize: 12),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      const Padding(padding: const EdgeInsets.only(top: 13)),
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
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: viewModel.localList.length,
                                  //아이템간의 간격을 조절하는 코드
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin: const EdgeInsets.only(top: 2),
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.085,
                                      child: CustomLocalSelectBtn(
                                        local: viewModel.localList[index],
                                        onTap: () =>
                                            viewModel.toggleLocalBtn(index),
                                      ),
                                    );
                                  }),
                            ),
                            const Padding(padding: EdgeInsets.only(left: 2)),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: viewModel.regionList.length,
                                  //아이템간의 간격을 조절하는 코드
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin: const EdgeInsets.only(top: 2),
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.085,
                                      child: CustomRegionSelectBtn(
                                        region: viewModel.regionList[index],
                                        onTap: () =>
                                            viewModel.toggleRegionBtn(index),
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
                            controller: _careerController,
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
                            hintText: "업무방식을 입력해주세요.",
                            obscureText: false,
                            controller: _careerController,
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
                            hintText: "업무방식을 입력해주세요.",
                            obscureText: false,
                            controller: _careerController,
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
                          itemCount: viewModel.testImg.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1 / 1,
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 20),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              child: ImageBox(
                                image: viewModel.testImg[index].image,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 0),
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
      ),
    );
  }
}
