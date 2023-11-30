import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/CustomConfirmBtn.dart';
import '../../widget/CustomTextField.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _userEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => null,
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(children: [
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
                          "비밀번호 변경",
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
                      child: CustomTextField(
                          hintText: "새 비밀번호",
                          obscureText: true,
                          controller: _userEmail,
                          keyboardType: TextInputType.visiblePassword),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: CustomTextField(
                          hintText: "새 비밀번호 확인",
                          obscureText: true,
                          controller: _userEmail,
                          keyboardType: TextInputType.visiblePassword),
                    ),
                  ]),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: CustomConfirmBtn(
                      text: "완료",
                      onPressed: () {},
                      backgroundColor: const Color(0xFF2D8CF4),
                      textColor: Colors.white,
                      textSize: 12),
                ),
              ]),
            ),
          ),
        ));
  }
}
