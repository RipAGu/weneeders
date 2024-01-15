import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/Main/MainViewModel.dart';
import 'package:winit/view/MainBottomNavigationBar.dart';
import 'package:winit/view/Recomend/RecommendViewModel.dart';
import 'package:winit/view/SkillData/SkillDataViewModel.dart';
import 'package:winit/view/account/SignInPage.dart';
import 'package:winit/view/chat/ChatViewModel.dart';
import 'package:winit/view/feed/FeedViewModel.dart';
import 'package:winit/view/project/Detail/DetailViewModel.dart';
import 'package:winit/view/project/Register/AddViewModel.dart';
import 'package:winit/view/project/Search/SearchViewModel.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.requestPermission(
    badge: true,
    alert: true,
    sound: true,
  );

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // 앱이 실행중인 상태에서 푸시를 클릭하여 앱을 실행시킨 경우
    if (message != null) {
      if (message.notification != null) {
        print('Message clicked!');
        print(message.notification!.body);
      }
    }
  });

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    // 앱이 종료된 상태에서 푸시를 클릭하여 앱을 실행시킨 경우
    if (message != null) {
      if (message.notification != null) {
        print('Message clicked!');
        print(message.notification!.body);
      }
    }
  });
  tz.initializeTimeZones();
  const storage = FlutterSecureStorage();
  String? token = await storage.read(key: "token");

  runApp(MyApp(
    startPage:
        token == null ? const SignInPage() : const MainBottomNavigationBar(),
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
        ChangeNotifierProvider(create: (context) => DetailViewModel()),
        ChangeNotifierProvider(create: (context) => AddViewModel()),
        ChangeNotifierProvider(create: (context) => ChatViewModel()),
        ChangeNotifierProvider(create: (context) => SkillDataViewModel()),
        ChangeNotifierProvider(create: (context) => FeedViewModel()),
        ChangeNotifierProvider(create: (context) => RecommendViewModel()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko', 'KR'),
        ],
        title: 'Flutter Demo',
        home: Scaffold(body: startPage),
      ),
    );
  }
}
