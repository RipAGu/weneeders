import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomConfirmBtnBorder extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double textSize;

  const CustomConfirmBtnBorder({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    required this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        backgroundColor: backgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
          side: const BorderSide(color: Color(0xffa9b0b8), width: 1),
        ),
      ),
      child: Text(text,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: textColor,
            fontSize: textSize,
          )),
    );
  }
}
