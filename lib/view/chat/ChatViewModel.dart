import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:winit/network/ApiService.dart';
import 'package:winit/network/model/ChatMessageModel.dart';

import '../../network/model/ChattingRoomModel.dart';

class ChatViewModel with ChangeNotifier {
  final ApiService apiService = ApiService();
  late int userIdx;
  int lastMessageIdx = 0;
  List<ChattingRoomModel> chattingRoomList = [];

  Future<void> init() async {
    userIdx = 0;
    lastMessageIdx = 0;
    chatMessageList.clear();
  }

  final List<ChatMessageModel> chatMessageList = [];

  Future<void> getChattingRoomList() async {
    chattingRoomList = [];
    try {
      final response = await apiService.getChattingRoomList();
      print(response.data);
      //+9시간 해줘야함
      for (var item in response.data) {
        try {
          DateTime date = DateTime.parse(item['curMessageTime']);
          date = date.add(const Duration(hours: 9));
          String formattedDate =
              "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";
          item['curMessageTime'] = formattedDate;
          chattingRoomList.add(ChattingRoomModel.fromJson(item));
        } catch (e) {
          print(e);
        }
      }

      print(response.data);
    } on DioException catch (e) {
      print(e);
    }
  }

  void addMessage(ChatMessageModel message) {
    chatMessageList.add(message);
    notifyListeners();
  }

  Future<void> setUserIdx(int idx) async {
    userIdx = idx;
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
      final response = await apiService.getChatMessage(roomIdx, lastMessageIdx);
      print(response.data);
      // myMessageState: true 인 경우 type = send로 설정
      // myMessageState: false 인 경우 type = receive로 설정
      for (var item in response.data) {
        DateTime date = DateTime.parse(item['createdAt']);
        String formattedDate =
            "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";
        item['createdAt'] = formattedDate;
        if (item['myMessageState'] == true) {
          item['type'] = "send";
          print(item['type']);
        } else {
          item['type'] = "receive";
        }
        print(item['type']);
        chatMessageList.add(ChatMessageModel.fromJson(item));
        notifyListeners();
      }
    } on DioException catch (e) {
      print(e);
    }
  }
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
