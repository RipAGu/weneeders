import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:winit/network/model/ChatMessageModel.dart';

class ChatBubbleSend extends StatelessWidget {
  final ChatMessageModel message;
  const ChatBubbleSend({Key? key, required this.message}) : super(key: key);

  //2024.1.5 15:10 형식을 15:10 형식으로 바꿔주는 함수

  @override
  Widget build(BuildContext context) {
    String createdAt = message.createdAt;
    DateTime parsedDate;
    parsedDate = DateFormat('yyyy.M.d H:mm').parse(createdAt);
    String formattedDate = DateFormat('HH:mm').format(parsedDate);

    return Container(
      margin: const EdgeInsets.only(top: 10, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formattedDate,
            style: const TextStyle(fontSize: 10),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xffCBE4FF),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            child: Text(
              message.message,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff333333),
              ),
            ),
          )
        ],
      ),
    );
  }
}
