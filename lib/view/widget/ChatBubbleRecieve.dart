import 'package:flutter/cupertino.dart';
import 'package:winit/network/model/ChatMessageModel.dart';

class ChatBubbleReceive extends StatelessWidget {
  final ChatMessageModel message;
  const ChatBubbleReceive({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xffF3F7F8),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
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
          ),
          const Padding(padding: EdgeInsets.only(left: 10)),
          Text(
            message.createdAt,
            style: const TextStyle(fontSize: 10, color: Color(0xff7D8791)),
          ),
        ],
      ),
    );
  }
}
