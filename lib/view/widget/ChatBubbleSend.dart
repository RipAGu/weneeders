import 'package:flutter/cupertino.dart';

class ChatBubbleSend extends StatelessWidget {
  const ChatBubbleSend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "오후 4:16",
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
            child: const Text(
              "testsdfsdf",
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
