import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:winit/view/account/SignInPage.dart';

class CustomDrawer extends StatelessWidget {
  final storage = const FlutterSecureStorage();
  const CustomDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Weneeders',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                )),
          ),
          ListTile(
            title: const Text(
              '프로필',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text('프로필 수정',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
            onTap: () {},
          ),
          ListTile(
            title: const Text('마이 프로젝트 등록',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
            onTap: () {},
          ),
          ListTile(
            title: const Text('마이 파트너 등록',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
            onTap: () {},
          ),
          ListTile(
            title: const Text('로그아웃',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
            onTap: () async {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const SignInPage()), // 새로 이동할 페이지
                (Route<dynamic> route) => false, // false를 반환하여 모든 이전 라우트들을 제거
              );
              await storage.delete(key: "token");
            },
          ),
        ],
      ),
    );
  }
}
