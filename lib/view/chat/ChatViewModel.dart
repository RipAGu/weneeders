import 'package:flutter/cupertino.dart';

class ChatViewModel with ChangeNotifier {
  final List<ChatData> _chatList = [
    ChatData(isNew: true, name: "김민수", content: "안녕하세요", date: "2021.09.01"),
    ChatData(isNew: false, name: "김민수", content: "안녕하세요", date: "2021.09.01"),
    ChatData(isNew: false, name: "김민수", content: "안녕하세요", date: "2021.09.01"),
    ChatData(isNew: false, name: "김민수", content: "안녕하세요", date: "2021.09.01"),
    ChatData(isNew: false, name: "김민수", content: "안녕하세요", date: "2021.09.01"),
    ChatData(isNew: false, name: "김민수", content: "안녕하세요", date: "2021.09.01"),
    ChatData(isNew: false, name: "김민수", content: "안녕하세요", date: "2021.09.01"),
  ];

  List<ChatData> get chatList => _chatList;
}

class ChatData {
  final bool isNew;
  final String name;
  final String content;
  final String date;

  ChatData({
    required this.isNew,
    required this.name,
    required this.content,
    required this.date,
  });
}
