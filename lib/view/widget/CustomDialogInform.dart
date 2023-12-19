import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogInform extends StatelessWidget {
  final String title;
  final String content;

  const CustomDialogInform({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                    )),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 16),
                ),
              ),
            )
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          //구분선
          height: 1,
          color: const Color(0xFFA6A6A6),
        ),
        const Padding(padding: EdgeInsets.only(top: 23)),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    content,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 12),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
