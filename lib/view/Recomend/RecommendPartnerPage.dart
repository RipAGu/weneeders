import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/widget/CustomDrawer.dart';
import 'package:winit/view/widget/TitleOnlyAppBar.dart';

import '../account/SignInPage.dart';
import '../project/Register/RegisterPartnerPage.dart';
import '../widget/CustomDialogSelect.dart';

class RecommendPartnerPage extends StatefulWidget {
  const RecommendPartnerPage({Key? key}) : super(key: key);

  @override
  State<RecommendPartnerPage> createState() => _RecommendPartnerPageState();
}

class _RecommendPartnerPageState extends State<RecommendPartnerPage> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          return Consumer(
              builder: (context, viewModel, child) => MaterialApp(
                    home: Scaffold(
                      body: SafeArea(
                        child: Container(),
                      ),
                      endDrawer: CustomDrawer(
                        onLogout: () {
                          showDialog(
                              context: context,
                              builder: (context) => CustomDialogSelect(
                                  title: "로그아웃",
                                  content: "로그아웃 하시겠습니까?",
                                  cancelText: "취소",
                                  confirmText: "확인",
                                  cancelPressed: () {
                                    Navigator.pop(context);
                                  },
                                  confirmPressed: () async {
                                    await storage.delete(key: "token");
                                    if (!mounted) return;
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const SignInPage()),
                                        (route) => false);
                                  }));
                        },
                        registerProject: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterPartnerPage()));
                        },
                        registerPartner: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterPartnerPage()));
                        },
                      ),
                      appBar: const TitleOnlyAppBar(
                        title: "파트너 추천",
                      ),
                    ),
                  ));
        });
  }
}
