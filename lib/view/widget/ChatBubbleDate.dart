import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubbleDate extends StatelessWidget {
  final String date;
  const ChatBubbleDate({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(top: 7, bottom: 7, left: 15, right: 15),
        decoration: const BoxDecoration(
          color: Color(0xffA9B0B8),
          borderRadius: BorderRadius.all(Radius.circular(999)),
        ),
        child: Text(
          date,
          style: const TextStyle(fontSize: 10, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
