import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/Main/MainViewModel.dart';
import 'package:winit/view/account/SignInPage.dart';
import 'package:winit/view/account/register/RegisterViewModel.dart';
import 'package:winit/view/chat/ChatViewModel.dart';
import 'package:winit/view/project/SearchViewModel.dart';

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
        ChangeNotifierProvider(create: (context) => SearchViewModel()),
        ChangeNotifierProvider(create: (context) => ChatViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
        ChangeNotifierProvider(create: (context) => MainViewModel()),
      ],
      child: const CupertinoApp(
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
        ),
        title: 'Flutter Demo',
        home: SignInPage(),
      ),
    );
  }
}
