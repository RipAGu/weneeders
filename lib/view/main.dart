import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winit/view/Main/MainPage.dart';
import 'package:winit/view/MainBottomNavigationBar.dart';
import 'package:winit/view/account/SignInPage.dart';
import 'package:winit/view/project/DetailProjectPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        primaryColor: Colors.white,
        brightness: Brightness.light,
      ),
      title: 'Flutter Demo',
      home: DetailProjectPage(),
    );
  }
}
