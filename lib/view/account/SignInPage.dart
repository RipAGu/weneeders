import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:winit/view/widget/CustomTextField.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _userPassword = TextEditingController();
  final String logo = "assets/icons/logo.svg";
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 110),
              child: Column(
                children: [
                  SvgPicture.asset(
                    logo,
                    width: MediaQuery.of(context).size.width * 0.2,
                    semanticsLabel: "logo",
                  ),
                  const Padding(padding: EdgeInsets.only(top: 50)),
                  const Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: CustomTextField(
                          hintText: "이메일",
                          obscureText: false,
                          controller: _userEmail,
                          keyboardType: TextInputType.emailAddress)),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: CustomTextField(
                          hintText: "비밀번호",
                          obscureText: true,
                          controller: _userPassword,
                          keyboardType: TextInputType.visiblePassword)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "아이디 찾기",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                      ),
                      const Text(
                        " | ",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 12),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "비밀번호 찾기",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                      ),
                      const Text(" | ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 12)),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "회원가입",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D8CF4),
                        elevation: 0,
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.85,
                            MediaQuery.of(context).size.height * 0.06),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    child: const Text(
                      "로그인",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 26))
                ],
              ),
            )));
  }
}
