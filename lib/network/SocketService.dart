import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:winit/network/model/ChatMessageModel.dart';
import 'package:winit/view/chat/ChatViewModel.dart';

class SocketService {
  late IO.Socket socket;

  void createSocketConnection(BuildContext context) {
    socket = IO.io('http://13.125.70.49:3001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();

    socket.on("new_chat_message", (data) {
      final chatViewModel = Provider.of<ChatViewModel>(context, listen: false);
      chatViewModel.addMessage(ChatMessageModel(
          idx: data["chattingRoomIdx"],
          message: data["message"],
          createdAt: data["createdAt"],
          myMessageState: false,
          type: "receive"));
    });

    socket.onConnect(
      (data) => {print("connect")},
    );

    socket.onDisconnect((_) => print('disconnect'));
  }

  void closeSocketConnection() {
    socket.disconnect();
  }
}
