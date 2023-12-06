import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/widget/CustomTextField.dart';
import 'package:winit/view/widget/CustomTextFieldGray.dart';
import 'package:winit/view/widget/SearchAppBar.dart';

import '../widget/CustomCheckboxTile.dart';
import 'AddViewModel.dart';

class RegisterPartnerPage extends StatefulWidget {
  const RegisterPartnerPage({Key? key}) : super(key: key);

  @override
  State<RegisterPartnerPage> createState() => _RegisterPartnerPageState();
}

class _RegisterPartnerPageState extends State<RegisterPartnerPage> {
  List<Item> testList = [
    Item(title: "전문분야1", isChecked: false),
    Item(title: "전문분야2", isChecked: true),
    Item(title: "전문분야3", isChecked: false),
    Item(title: "전문분야4", isChecked: false),
    Item(title: "전문분야5", isChecked: false),
    Item(title: "전문분야6", isChecked: false),
    Item(title: "전문분야7", isChecked: false),
    Item(title: "전문분야8", isChecked: false),
    Item(title: "전문분야9", isChecked: false),
    Item(title: "전문분야10", isChecked: false),
  ];
  final TextEditingController _careerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AddViewModel>(context);
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: const SearchAppBar(title: "파트너 등록"),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 23),
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
                    Padding(padding: const EdgeInsets.only(top: 13)),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: testList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 8 / 1,
                                crossAxisCount: 3,
                                mainAxisSpacing: 20),
                        itemBuilder: (BuildContext context, int index) {
                          return CustomCheckboxTile(
                            item: viewModel.testList[index],
                            onTap: () => viewModel.toggleCheckbox(index),
                          );
                        }),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Container(
                      height: 40,
                      child: CustomTextFieldGray(
                          hintText: "직접입력",
                          obscureText: false,
                          controller: _careerController,
                          keyboardType: TextInputType.text,
                          textFontSize: 12),
                    ),
                  ])),
            ),
          )),
    );
  }
}
