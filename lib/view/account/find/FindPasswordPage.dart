import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/account/find/ChangePasswordPage.dart';

import '../../widget/CustomConfirmBtn.dart';
import '../../widget/CustomTextField.dart';

class FindPasswordPage extends StatefulWidget {
  const FindPasswordPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _verifyCode = TextEditingController();
  final TextEditingController _userPhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => null,
        child: CupertinoPageScaffold(
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
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
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              "비밀번호 찾기",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width * 0.9,
                      //구분선
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: Column(children: [
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.63,
                                  child: CustomTextField(
                                      hintText: "이메일",
                                      obscureText: false,
                                      controller: _userEmail,
                                      keyboardType: TextInputType.name),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: CustomConfirmBtn(
                                      text: "인증요청",
                                      onPressed: () {},
                                      backgroundColor: const Color(0xFF2D8CF4),
                                      textColor: Colors.white,
                                      textSize: 12,
                                    )),
                              ],
                            )),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.63,
                                  child: CustomTextField(
                                      hintText: "연락처",
                                      obscureText: false,
                                      controller: _userPhone,
                                      keyboardType: TextInputType.name),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
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
                            margin: const EdgeInsets.only(top: 10),
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.63,
                                  child: CustomTextField(
                                      hintText: "인증번호",
                                      obscureText: false,
                                      controller: _verifyCode,
                                      keyboardType: TextInputType.name),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: CustomConfirmBtn(
                                      text: "인증요청",
                                      onPressed: () {},
                                      backgroundColor: const Color(0xFF2D8CF4),
                                      textColor: Colors.white,
                                      textSize: 12,
                                    ))
                              ],
                            )),
                      ]),
                    ),
                    Spacer(),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: CustomConfirmBtn(
                          text: "비밀번호 변경",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangePasswordPage()));
                          },
                          backgroundColor: const Color(0xFF2D8CF4),
                          textColor: Colors.white,
                          textSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
