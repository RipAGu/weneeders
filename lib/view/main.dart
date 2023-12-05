import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/Main/MainPage.dart';
import 'package:winit/view/MainBottomNavigationBar.dart';
import 'package:winit/view/account/SignInPage.dart';
import 'package:winit/view/account/register/RegisterAgreePage.dart';
import 'package:winit/view/account/register/RegisterViewModel.dart';
import 'package:winit/view/chat/ChatListPage.dart';
import 'package:winit/view/chat/ChatViewModel.dart';
import 'package:winit/view/project/AddFeedPage.dart';
import 'package:winit/view/project/DetailProjectPage.dart';
import 'package:winit/view/project/SearchProjectPage.dart';
import 'package:winit/view/project/SearchProjectViewModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchProjectViewModel()),
        ChangeNotifierProvider(create: (context) => ChatViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
      ],
      child: const CupertinoApp(
        theme: CupertinoThemeData(
          brightness: Brightness.light,
        ),
        title: 'Flutter Demo',
        home: SignInPage(),
      ),
    );
  }
}
