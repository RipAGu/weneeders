import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/CustomConfirmBtn.dart';
import 'FindViewModel.dart';

class PrintEmailPage extends StatefulWidget {
  final userEmail;
  const PrintEmailPage({super.key, required this.userEmail});

  @override
  State<PrintEmailPage> createState() => _PrintEmailPageState();
}

class _PrintEmailPageState extends State<PrintEmailPage> {
  late String userEmail = widget.userEmail;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FindViewModel(),
        child: Consumer<FindViewModel>(
          builder: (context, viewModel, child) => Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const Stack(
                      children: [
                        Align(
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
                    Center(
                      child: Text(
                        "회원님의 이메일은 $userEmail 입니다.",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: CustomConfirmBtn(
                          text: "로그인 하러 가기",
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                          backgroundColor: const Color(0xFF2D8CF4),
                          textColor: Colors.white,
                          textSize: 12),
                    ),
                  ],
                ),
              ),
            )),
          ),
        ));
  }
}
