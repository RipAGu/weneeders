import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomDrawer extends StatelessWidget {
  final Function onLogout;
  final Function registerProject;
  final Function registerPartner;
  final storage = const FlutterSecureStorage();
  const CustomDrawer(
      {super.key,
      required this.onLogout,
      required this.registerProject,
      required this.registerPartner});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
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
            onTap: () {
              registerProject();
            },
          ),
          ListTile(
            title: const Text('마이 파트너 등록',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
            onTap: () {
              registerPartner();
            },
          ),
          ListTile(
            title: const Text('로그아웃',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
            onTap: () async {
              onLogout();
            },
          ),
        ],
      ),
    );
  }
}
