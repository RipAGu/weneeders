import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubbleDate extends StatelessWidget {
  const ChatBubbleDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.only(top: 7, bottom: 7, left: 15, right: 15),
        decoration: const BoxDecoration(
          color: Color(0xffA9B0B8),
          borderRadius: BorderRadius.all(Radius.circular(999)),
        ),
        child: Text(
          "2021년 10월 10일 금요일",
          style: const TextStyle(fontSize: 10, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
