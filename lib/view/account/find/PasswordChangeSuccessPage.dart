import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:winit/view/account/SignInPage.dart';

import '../../widget/CustomConfirmBtn.dart';

class PasswordChangeSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비밀번호 변경'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.9,
                //구분선
                height: 1,
                color: Colors.grey[300],
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/icons/logo.svg",
                semanticsLabel: "logo",
              ),
              const Padding(padding: EdgeInsets.only(top: 28)),
              const Text(
                "회원가입이 완료되었습니다.",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 16),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 26),
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.06,
                child: CustomConfirmBtn(
                    text: '로그인화면으로 이동',
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SignInPage()), // 새로 이동할 페이지
                        (Route<dynamic> route) =>
                            false, // false를 반환하여 모든 이전 라우트들을 제거
                      );
                    },
                    backgroundColor: const Color(0xff2d8cf4),
                    textColor: Colors.white,
                    textSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
