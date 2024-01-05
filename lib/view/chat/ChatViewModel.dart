import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:winit/network/ApiService.dart';
import 'package:winit/network/model/ChatMessageModel.dart';

import '../../network/model/ChattingRoomModel.dart';

class ChatViewModel with ChangeNotifier {
  final ApiService apiService = ApiService();
  late int userIdx;
  int lastMessageIdx = 0;
  List<ChattingRoomModel> chattingRoomList = [];
  bool isLastMessage = false;

  VoidCallback? onMessageAdded;

  Future<void> init() async {
    userIdx = 0;
    lastMessageIdx = 0;
    chatMessageList = [];
    isLastMessage = false;
  }

  List<ChatMessageModel> chatMessageList = [];

  Future<void> getChattingRoomList() async {
    chattingRoomList = [];
    try {
      final response = await apiService.getChattingRoomList();
      log(response.data.toString());
      //+9시간 해줘야함
      for (var item in response.data) {
        try {
          DateTime date = DateTime.parse(item['curMessageTime']);
          date = date.add(const Duration(hours: 9));
          String formattedDate =
              "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";
          item['curMessageTime'] = formattedDate;
          chattingRoomList.add(ChattingRoomModel.fromJson(item));
          log(chattingRoomList.toString());
        } catch (e) {
          print(e);
        }
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  void addMessage(ChatMessageModel message) {
    chatMessageList.add(message);
    notifyListeners();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      onMessageAdded?.call();
    });
    notifyListeners();
  }

  Future<void> setUserIdx(int idx) async {
    userIdx = idx;
  }

  Future<void> sendChatMessage(int toUserIdx, String message) async {
    try {
      final response = await apiService.postChatMessage(toUserIdx, message);
      var sendTime = DateTime.now();
      sendTime.add(const Duration(hours: 9));
      String formattedDate =
          "${sendTime.year}.${sendTime.month}.${sendTime.day} ${sendTime.hour}:${sendTime.minute}";
      addMessage(ChatMessageModel(
          idx: 9999,
          message: message,
          myMessageState: true,
          createdAt: formattedDate,
          type: "send"));
      notifyListeners();
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> getChatMessage(int roomIdx) async {
    print(lastMessageIdx);
    try {
      final response = await apiService.getChatMessage(roomIdx, lastMessageIdx);
      List<ChatMessageModel> newMessages = [];

      // 메시지 처리
      for (var item in response.data) {
        DateTime date =
            DateTime.parse(item['createdAt']).add(const Duration(hours: 9));
        String formattedDate =
            "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";
        item['createdAt'] = formattedDate;
        item['type'] = item['myMessageState'] ? "send" : "receive";
        newMessages.add(ChatMessageModel.fromJson(item));
      }

      // 메시지 리스트를 역순으로 정렬
      newMessages = newMessages.reversed.toList();

      // 날짜별로 그룹화 및 날짜 메시지 추가
      DateTime? lastDate;
      for (var i = 0; i < newMessages.length; i++) {
        DateTime? messageDate = parseDate(newMessages[i].createdAt);
        if (messageDate == null) continue;

        if (lastDate == null || !isSameDay(lastDate, messageDate)) {
          lastDate = messageDate;
          //날짜의 요일 구하기 형식은 월요일
          String dayOfWeek = "";
          switch (messageDate.weekday) {
            case 1:
              dayOfWeek = "월요일";
              break;
            case 2:
              dayOfWeek = "화요일";
              break;
            case 3:
              dayOfWeek = "수요일";
              break;
            case 4:
              dayOfWeek = "목요일";
              break;
            case 5:
              dayOfWeek = "금요일";
              break;
            case 6:
              dayOfWeek = "토요일";
              break;
            case 7:
              dayOfWeek = "일요일";
              break;
          }

          String dateString =
              "${messageDate.year}년 ${messageDate.month}월${messageDate.day}일 $dayOfWeek";
          newMessages.insert(
              i,
              ChatMessageModel(
                  idx: newMessages[i].idx,
                  message: dateString,
                  myMessageState: false,
                  createdAt: "",
                  type: "date"));
          i++;
        }
      }

      // 기존 리스트와 새 메시지 리스트의 날짜 중복 제거
      if (chatMessageList.isNotEmpty && newMessages.isNotEmpty) {
        DateTime lastNewMessageDate =
            parseDate(newMessages.last.createdAt) ?? DateTime.now();
        DateTime firstOldMessageDate =
            parseDate(chatMessageList.first.createdAt) ?? DateTime.now();

        if (isSameDay(lastNewMessageDate, firstOldMessageDate)) {
          chatMessageList.removeAt(0); // 기존 리스트의 첫 번째 날짜 메시지 제거
        }
      }

      // 새 메시지 리스트를 기존 메시지 리스트 앞에 추가
      chatMessageList.insertAll(0, newMessages);

      // 마지막 메시지 인덱스 업데이트
      if (newMessages.isNotEmpty) {
        lastMessageIdx = chatMessageList.first.idx;
      } else {
        isLastMessage = true;
      }

      notifyListeners();
    } on DioException catch (e) {
      print(e);
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  DateTime? parseDate(String dateString) {
    try {
      return DateFormat("yyyy.M.d H:mm").parse(dateString);
    } catch (e) {
      print("날짜 파싱 오류: $e");
      return null;
    }
  }
}
