import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/account/register/CustomerRegisterPage.dart';
import 'package:winit/view/account/register/ExpertRegisterPage.dart';
import 'package:winit/view/account/register/RegisterViewModel.dart';
import 'package:winit/view/widget/CustomCheckBoxBlack.dart';
import 'package:winit/view/widget/CustomCheckBoxGray.dart';
import 'package:winit/view/widget/CustomConfirmBtn.dart';
import 'package:winit/view/widget/CustomDialogInform.dart';

class RegisterAgreePage extends StatefulWidget {
  const RegisterAgreePage({Key? key}) : super(key: key);
  @override
  State<RegisterAgreePage> createState() => _RegisterAgreePageState();
}

class _RegisterAgreePageState extends State<RegisterAgreePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: RegisterAgreePageBody(),
      ),
    );
  }
}

class RegisterAgreePageBody extends StatelessWidget {
  const RegisterAgreePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);
    return SafeArea(
      child: SizedBox(
          child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(children: [
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
                    "회원가입 동의",
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
          const Padding(padding: EdgeInsets.only(top: 23)),
          const Text(
            "서비스 시작 및 가입을 위하여 먼저\n가입 및 정보 제공에 동의해 주세요.",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Color(0xFF36393B),
                height: 1.5,
                fontSize: 12),
          ),
          const Padding(padding: EdgeInsets.only(top: 28)),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 3),
                      child: CustomCheckBoxBlack(
                          isChecked: viewModel.isTotalCheck,
                          onChanged: (value) {
                            viewModel.setTotalCheck(value);
                          }),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 5)),
                    const Text(
                      "전체동의",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF36393B),
                          fontSize: 14),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14),
                  //구분선
                  height: 1,
                  color: Colors.grey[300],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14),
                  child: Row(
                    children: [
                      CustomCheckBoxGray(
                          isChecked: viewModel.isServiceCheck,
                          onChanged: (value) {
                            viewModel.setServiceCheck(value);
                          }),
                      const Padding(padding: EdgeInsets.only(left: 5)),
                      const Text(
                        "서비스 이용 약관",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7D8690),
                            fontSize: 14),
                      ),
                      const Spacer(),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      child: CustomDialogInform(
                                        title: "서비스 이용 약관",
                                        content: "서비스 이용 약관입니다.",
                                      )),
                                );
                              });
                        },
                        child: SvgPicture.asset(
                          'assets/icons/arrow_right.svg',
                        ),
                      ),
                    ],
                  ),
                ),
                //구분선
                Container(
                  margin: const EdgeInsets.only(top: 14),
                  height: 1,
                  color: Colors.grey[300],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14),
                  child: Row(
                    children: [
                      CustomCheckBoxGray(
                          isChecked: viewModel.isPrivacyCheck,
                          onChanged: (value) {
                            viewModel.setPrivacyCheck(value);
                          }),
                      const Padding(padding: EdgeInsets.only(left: 5)),
                      const Text(
                        "개인정보 수집 및 이용 동의",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7D8690),
                            fontSize: 14),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        'assets/icons/arrow_right.svg',
                      ),
                    ],
                  ),
                ),
                //구분선
                Container(
                  margin: const EdgeInsets.only(top: 14),
                  height: 1,
                  color: Colors.grey[300],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14),
                  child: Row(
                    children: [
                      CustomCheckBoxGray(
                          isChecked: viewModel.isMarketingCheck,
                          onChanged: (value) {
                            viewModel.setMarketingCheck(value);
                          }),
                      const Padding(padding: EdgeInsets.only(left: 5)),
                      const Text(
                        "개인정보 제3자 제공 동의",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7D8690),
                            fontSize: 14),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        'assets/icons/arrow_right.svg',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(bottom: 20, left: 26, right: 26),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: CustomConfirmBtn(
                        text: "업체 회원가입",
                        onPressed: () {
                          viewModel.isAllChecked
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CustomerRegisterPage()))
                              : null;
                        },
                        backgroundColor: const Color(0xFF7D8690),
                        textSize: 12,
                        textColor: Colors.white),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: CustomConfirmBtn(
                        text: "파트너 회원가입",
                        textSize: 12,
                        onPressed: () {
                          viewModel.isAllChecked
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ExpertRegisterPage()))
                              : null;
                        },
                        backgroundColor: const Color(0xFF2D8CF4),
                        textColor: Colors.white),
                  ),
                ]),
          ),
        ]),
      )),
    );
  }
}
