import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/account/register/RegisterViewModel.dart';

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
  final TextEditingController _userPassword = TextEditingController();
  final TextEditingController _userPasswordCheck = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _userNickname = TextEditingController();
  final TextEditingController _userPhone = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();
  final TextEditingController _verifyCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterViewModel(),
      child: Consumer<RegisterViewModel>(
        builder: (context, viewModel, child) => Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
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
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.black,
                                        )),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "파트너 회원가입",
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 26),
                              child: Column(children: [
                                Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.63,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          child: CustomTextField(
                                              isEditable:
                                                  !viewModel.isEmailCheck,
                                              hintText: "이메일",
                                              obscureText: false,
                                              controller: _userEmail,
                                              keyboardType: TextInputType.name,
                                              textFontSize: 12),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            child: CustomConfirmBtnBorder(
                                              text: "중복확인",
                                              onPressed: () async {
                                                if (viewModel.emailRegexCheck(
                                                    _userEmail.text)) {
                                                  await viewModel
                                                      .emailDupleCheck(
                                                          _userEmail.text);
                                                  if (!mounted) return;
                                                  if (viewModel.isEmailCheck) {
                                                    showSnackBar(context,
                                                        "사용가능한 이메일입니다.");
                                                  } else {
                                                    showSnackBar(context,
                                                        "이미 사용중인 이메일입니다.");
                                                  }
                                                } else {
                                                  showSnackBar(context,
                                                      "이메일 형식이 올바르지 않습니다.");
                                                }
                                              },
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              textSize: 12,
                                            ))
                                      ],
                                    )),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: CustomTextField(
                                      hintText: "비밀번호",
                                      obscureText: true,
                                      controller: _userPassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textFontSize: 12),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: CustomTextField(
                                      hintText: "비밀번호 확인",
                                      obscureText: true,
                                      controller: _userPasswordCheck,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textFontSize: 12),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: CustomTextField(
                                      hintText: "이름",
                                      obscureText: true,
                                      controller: _userPasswordCheck,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textFontSize: 12),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.63,
                                          child: CustomTextField(
                                              hintText: "닉네임",
                                              obscureText: false,
                                              controller: _userNickname,
                                              keyboardType: TextInputType.name,
                                              isEditable:
                                                  !viewModel.nickNameCheck,
                                              textFontSize: 12),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            child: CustomConfirmBtnBorder(
                                              text: "중복확인",
                                              onPressed: () async {
                                                await viewModel
                                                    .nickNameDupleCheck(
                                                        _userNickname.text);
                                                if (!mounted) return;
                                                if (viewModel.nickNameCheck) {
                                                  showSnackBar(
                                                      context, "사용가능한 닉네임입니다.");
                                                } else {
                                                  showSnackBar(context,
                                                      "이미 사용중인 닉네임입니다.");
                                                }
                                              },
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              textSize: 12,
                                            ))
                                      ],
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.63,
                                          child: CustomTextField(
                                              hintText: "연락처",
                                              obscureText: false,
                                              controller: _userPhone,
                                              isEditable:
                                                  !viewModel.isSendPhone,
                                              keyboardType:
                                                  TextInputType.number,
                                              textFontSize: 12),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            child: CustomConfirmBtn(
                                              text: "인증요청",
                                              onPressed: () {
                                                viewModel.isSendPhone
                                                    ? null
                                                    : viewModel.phoneVerify(
                                                        _userPhone.text);
                                              },
                                              backgroundColor:
                                                  viewModel.isSendPhone
                                                      ? const Color(0xffA9B0B8)
                                                      : const Color(0xFF2D8CF4),
                                              textColor: Colors.white,
                                              textSize: 12,
                                            ))
                                      ],
                                    )),
                                Visibility(
                                  visible: viewModel.isSendPhone,
                                  child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.63,
                                            child: CustomTextField(
                                                hintText: "인증번호",
                                                obscureText: false,
                                                controller: _verifyCode,
                                                keyboardType:
                                                    TextInputType.number,
                                                textFontSize: 12),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              child: CustomConfirmBtn(
                                                text: "인증확인",
                                                onPressed: () {},
                                                backgroundColor:
                                                    const Color(0xFF2D8CF4),
                                                textColor: Colors.white,
                                                textSize: 12,
                                              ))
                                        ],
                                      )),
                                ),
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
      ),
    );
  }

  //snackBar
  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(milliseconds: 1000),
    ));
  }
}
