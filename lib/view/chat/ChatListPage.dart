import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/widget/SearchAppBar.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => null, child: MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: const SearchAppBar(title: "채팅"),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: Container(),
          ),
        ),
      ),
    ));
  }
}