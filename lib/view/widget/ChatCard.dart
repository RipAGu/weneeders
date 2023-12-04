import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatCard extends StatelessWidget {
  final bool isNew;
  final String name;
  final String content;
  final String date;
  final VoidCallback? onPressed;

  const ChatCard({
    Key? key,
    required this.isNew,
    required this.name,
    required this.content,
    required this.date,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isNew) {
      return GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.translucent,
        child: Container(
          decoration: const BoxDecoration(
              //radius
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xFF2D8DF4)),
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SvgPicture.asset("assets/icons/new.svg")
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ]),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.translucent,
        child: Container(
          decoration: const BoxDecoration(
              //radius
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xFFF2F6F8)),
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                date,
                style: const TextStyle(
                  color: Color(0xff7d8690),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ]),
        ),
      );
    }
  }
}
