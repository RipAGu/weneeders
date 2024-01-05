import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:winit/network/model/ChatMessageModel.dart';

class ChatBubbleReceive extends StatelessWidget {
  final ChatMessageModel message;
  const ChatBubbleReceive({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String createdAt = message.createdAt;
    DateTime parsedDate;

// ISO 8601 형식 확인 (예: 2024-01-05T17:11:52.931Z)
    bool isISO8601 = createdAt.contains('T') && createdAt.contains('Z');
    if (isISO8601) {
      // ISO 8601 형식의 날짜 처리
      parsedDate = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ')
          .parse(createdAt, true)
          .toLocal();
    } else {
      // 사용자 정의 형식 (예: 2024.1.5 17:11)의 날짜 처리
      try {
        parsedDate = DateFormat('yyyy.M.d H:mm').parse(createdAt);
      } catch (e) {
        print('날짜 파싱 오류: $e');
        // 오류 발생시 현재 날짜로 대체
        parsedDate = DateTime.now();
      }
    }

// 원하는 형식으로 날짜 포맷팅
    String formattedDate = DateFormat('HH:mm').format(parsedDate);

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
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff333333),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 10)),
          Text(
            formattedDate,
            style: const TextStyle(fontSize: 10, color: Color(0xff7D8791)),
          ),
        ],
      ),
    );
  }
}
