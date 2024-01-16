import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:winit/network/model/ChatMessageModel.dart';
import 'package:winit/view/chat/ChatViewModel.dart';

class SocketService {
  IO.Socket? socket;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  ChatViewModel? chatViewModel;
  SocketService._privateConstructor();
  static final SocketService _instance = SocketService._privateConstructor();
  factory SocketService() {
    return _instance;
  }
  void init(ChatViewModel viewModel) {
    chatViewModel = viewModel;
  }

  void createSocketConnection(BuildContext context) async {
    var token = await storage.read(key: "token");
    print("token : $token");
    if (socket != null && socket!.connected) {
      print("Socket is already connected.");
      return;
    }
    socket?.disconnect();
    socket?.clearListeners();

    socket = IO.io('http://13.125.70.49:3001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'extraHeaders': {'Authorization': 'Bearer ${token}'}
    });
    socket?.connect();

    socket?.on("message", (data) {
      print(data);
      chatViewModel?.addMessage(ChatMessageModel(
          idx: data["chattingRoomIdx"],
          message: data["message"],
          createdAt: data["createdAt"],
          myMessageState: false,
          type: "receive"));
    });

    socket?.on("unauthorized", (data) {
      print(data);
    });

    socket?.onConnect(
      (data) => {print("connect")},
    );

    socket?.onDisconnect((_) => print('disconnect'));
  }

  void closeSocketConnection() {
    socket?.disconnect();
  }
}
