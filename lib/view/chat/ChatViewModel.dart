import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:winit/network/ApiService.dart';
import 'package:winit/network/model/ChatMessageModel.dart';

class ChatViewModel with ChangeNotifier {
  final ApiService apiService = ApiService();
  final List<ChatData> _chatList = [
    ChatData(isNew: true, name: "김민수", content: "안녕하세요", date: "2021.09.01"),
    ChatData(isNew: false, name: "김민수", content: "안녕하세요", date: "2021.09.01"),
    ChatData(isNew: false, name: "김민수", content: "안녕하세요", date: "2021.09.01"),
    ChatData(isNew: false, name: "김민수", content: "안녕하세요", date: "2021.09.01"),
    ChatData(isNew: false, name: "김민수", content: "안녕하세요", date: "2021.09.01"),
    ChatData(isNew: false, name: "김민수", content: "안녕하세요", date: "2021.09.01"),
    ChatData(isNew: false, name: "김민수", content: "안녕하세요", date: "2021.09.01"),
  ];

  final List<ChatMessageModel> chatMessageList = [];

  void addMessage(ChatMessageModel message) {
    chatMessageList.add(message);
    notifyListeners();
  }

  Future<void> sendChatMessage(int toUserIdx, String message) async {
    try {
      final response = await apiService.postChatMessage(toUserIdx, message);
      print(response);
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> getChatMessage(int roomIdx) async {
    try {
      final response = await apiService.getChatMessage(roomIdx);
      print(response);
    } on DioException catch (e) {
      print(e);
    }
  }

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
