import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/Main/MainPage.dart';
import 'package:winit/view/Main/MainViewModel.dart';
import 'package:winit/view/account/SignInPage.dart';
import 'package:winit/view/account/register/RegisterViewModel.dart';
import 'package:winit/view/chat/ChatViewModel.dart';
import 'package:winit/view/project/Search/SearchViewModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const storage = FlutterSecureStorage();
  String? token = await storage.read(key: "token");

  runApp(MyApp(
    startPage: token == null ? const SignInPage() : const MainPage(),
  ));
}

class MyApp extends StatelessWidget {
  final Widget startPage;
  const MyApp({super.key, required this.startPage});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchViewModel()),
        ChangeNotifierProvider(create: (context) => ChatViewModel()),
        ChangeNotifierProvider(create: (context) => MainViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(body: startPage),
      ),
    );
  }
}
