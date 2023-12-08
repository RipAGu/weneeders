import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/widget/CustomCheckboxTile.dart';

import '../../widget/CustomConfirmBtn.dart';
import '../../widget/CustomConfirmBtnBorder.dart';
import '../../widget/CustomTextField.dart';
import 'RegisterSuccessPage.dart';

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
          child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
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
                                "전문가 회원가입",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.63,
                                    child: CustomTextField(
                                        hintText: "이름",
                                        obscureText: false,
                                        controller: _userEmail,
                                        keyboardType: TextInputType.name),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.63,
                                    child: CustomTextField(
                                        hintText: "이름",
                                        obscureText: false,
                                        controller: _userEmail,
                                        keyboardType: TextInputType.name),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.63,
                                    child: CustomTextField(
                                        hintText: "이름",
                                        obscureText: false,
                                        controller: _userEmail,
                                        keyboardType: TextInputType.name),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.63,
                                    child: CustomTextField(
                                        hintText: "이름",
                                        obscureText: false,
                                        controller: _userEmail,
                                        keyboardType: TextInputType.name),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      child: CustomConfirmBtn(
                                        text: "인증요청",
                                        onPressed: () {},
                                        backgroundColor:
                                            const Color(0xFF2D8CF4),
                                        textColor: Colors.white,
                                        textSize: 12,
                                      ))
                                ],
                              )),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Row(children: [
                            const Text("연락 가능한 시간",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                            const Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: CustomTextField(
                                  hintText: "",
                                  obscureText: false,
                                  controller: _userEmail,
                                  keyboardType: TextInputType.text),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: const Text("~",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: CustomTextField(
                                  hintText: "",
                                  obscureText: false,
                                  controller: _userEmail,
                                  keyboardType: TextInputType.text),
                            ),
                          ])
                        ]),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: CustomConfirmBtn(
                            text: "회원가입",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterSuccessPage()));
                            },
                            backgroundColor: const Color(0xFF2D8CF4),
                            textColor: Colors.white,
                            textSize: 12),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
