import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/MainBottomNavigationBar.dart';
import 'package:winit/view/widget/CustomConfirmBtn.dart';

class RegisterSuccessPage extends StatelessWidget {
  const RegisterSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => null,
      child: Scaffold(
        body: SafeArea(
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
                            "회원가입 완료",
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
                        text: '완료',
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MainBottomNavigationBar()), // 새로 이동할 페이지
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
        ),
      ),
    );
  }
}
