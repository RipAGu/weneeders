import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/MainBottomNavigationBar.dart';
import 'package:winit/view/account/find/FindAccountPage.dart';
import 'package:winit/view/account/find/FindPasswordPage.dart';
import 'package:winit/view/account/register/RegisterAgreePage.dart';
import 'package:winit/view/widget/CustomTextField.dart';

import 'SignInViewModel.dart';

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
    return ChangeNotifierProvider(
      create: (context) => SignInViewModel(),
      child: Consumer<SignInViewModel>(
        builder: (context, viewModel, child) => Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
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
                          keyboardType: TextInputType.emailAddress,
                          textFontSize: 12)),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: CustomTextField(
                          hintText: "비밀번호",
                          obscureText: true,
                          controller: _userPassword,
                          keyboardType: TextInputType.visiblePassword,
                          textFontSize: 12)),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FindAccountPage()));
                        },
                        child: const Text(
                          "이메일 찾기",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: const Text(
                          " | ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FindPasswordPage()));
                        },
                        child: const Text(
                          "비밀번호 찾기",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: const Text(" | ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 12)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterAgreePage()));
                        },
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
                    onPressed: () async {
                      if (_userEmail.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("이메일을 입력해주세요")));
                      } else if (_userPassword.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("비밀번호를 입력해주세요")));
                      } else {
                        await viewModel.login(
                            _userEmail.text, _userPassword.text);
                        if (!mounted) return;
                        if (viewModel.isLoginSuccess) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MainBottomNavigationBar()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("로그인 실패")));
                        }
                      }
                    },
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
            ))),
      ),
    );
  }
}
