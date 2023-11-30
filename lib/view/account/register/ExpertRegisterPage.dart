import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/widget/CustomCheckboxTile.dart';

import '../../widget/CustomConfirmBtn.dart';
import '../../widget/CustomConfirmBtnBorder.dart';
import '../../widget/CustomTextField.dart';

class ExpertRegisterPage extends StatefulWidget {
  const ExpertRegisterPage({Key? key}) : super(key: key);
  @override
  State<ExpertRegisterPage> createState() => _ExpertRegisterPageState();
}

class _ExpertRegisterPageState extends State<ExpertRegisterPage> {
  final TextEditingController _userEmail = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => null,
      child: CupertinoPageScaffold(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "고객 회원가입",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  //구분선
                  height: 1,
                  color: Colors.grey[300],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Column(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: CustomTextField(
                          hintText: "이메일",
                          obscureText: false,
                          controller: _userEmail,
                          keyboardType: TextInputType.emailAddress),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: CustomTextField(
                          hintText: "비밀번호",
                          obscureText: true,
                          controller: _userEmail,
                          keyboardType: TextInputType.visiblePassword),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: CustomTextField(
                          hintText: "비밀번호 확인",
                          obscureText: true,
                          controller: _userEmail,
                          keyboardType: TextInputType.visiblePassword),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.63,
                              child: CustomTextField(
                                  hintText: "이름",
                                  obscureText: false,
                                  controller: _userEmail,
                                  keyboardType: TextInputType.name),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: const ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                          color: Color(0xffa9b0b8)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3.0)),
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                      "assets/icons/profile_trans.svg",
                                      colorFilter: const ColorFilter.mode(
                                          Colors.black, BlendMode.srcIn)),
                                ))
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.63,
                              child: CustomTextField(
                                  hintText: "이름",
                                  obscureText: false,
                                  controller: _userEmail,
                                  keyboardType: TextInputType.name),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: CustomConfirmBtnBorder(
                                  text: "중복확인",
                                  onPressed: () {},
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  textSize: 12,
                                ))
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.63,
                              child: CustomTextField(
                                  hintText: "이름",
                                  obscureText: false,
                                  controller: _userEmail,
                                  keyboardType: TextInputType.name),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: CustomConfirmBtnBorder(
                                  text: "중복확인",
                                  onPressed: () {},
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  textSize: 12,
                                ))
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.63,
                              child: CustomTextField(
                                  hintText: "이름",
                                  obscureText: false,
                                  controller: _userEmail,
                                  keyboardType: TextInputType.name),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: CustomConfirmBtn(
                                  text: "인증요청",
                                  onPressed: () {},
                                  backgroundColor: const Color(0xFF2D8CF4),
                                  textColor: Colors.white,
                                  textSize: 12,
                                ))
                          ],
                        )),
                    Container(
                      height: 135,
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: GridView.builder(
                          itemCount: testList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 10 / 1,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20),
                          itemBuilder: (BuildContext context, int index) {
                            return CustomCheckboxTile(
                              item: testList[index],
                              onTap: () {
                                print(testList[index].title);
                              },
                            );
                          }),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
