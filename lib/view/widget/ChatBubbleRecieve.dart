import 'package:flutter/cupertino.dart';

class ChatBubbleReceive extends StatelessWidget {
  const ChatBubbleReceive({Key? key}) : super(key: key);

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
            child: const Text(
              "안녕하세요. 상담원하시는 시간 말씀해주시면 상담일정 변경하겠습니다.",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff333333),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 10)),
          Text(
            "오후 4:16",
            style: const TextStyle(fontSize: 10, color: Color(0xff7D8791)),
          ),
        ],
      ),
    );
  }
}
