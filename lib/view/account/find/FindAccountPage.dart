import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/CustomConfirmBtn.dart';
import '../../widget/CustomTextField.dart';

class FindAccountPage extends StatefulWidget {
  const FindAccountPage({Key? key}) : super(key: key);

  @override
  State<FindAccountPage> createState() => _FindAccountPageState();
}

class _FindAccountPageState extends State<FindAccountPage> {
  final TextEditingController _userPhone = TextEditingController();
  final TextEditingController _verifyCode = TextEditingController();

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
                            "이메일 찾기",
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
                                width: MediaQuery.of(context).size.width * 0.63,
                                child: CustomTextField(
                                    hintText: "이름",
                                    obscureText: false,
                                    controller: _userPhone,
                                    keyboardType: TextInputType.name,
                                    textFontSize: 12),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
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
                                width: MediaQuery.of(context).size.width * 0.63,
                                child: CustomTextField(
                                  hintText: "이름",
                                  obscureText: false,
                                  controller: _verifyCode,
                                  keyboardType: TextInputType.name,
                                  textFontSize: 12,
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
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
                    ]),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: CustomConfirmBtn(
                        text: "이메일 찾기",
                        onPressed: () {},
                        backgroundColor: const Color(0xFF2D8CF4),
                        textColor: Colors.white,
                        textSize: 12),
                  ),
                ],
              ),
            ),
          )),
        ));
  }
}
