import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFieldGray extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final double textFontSize;

  const CustomTextFieldGray({
    Key? key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.keyboardType,
    required this.textFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      style: TextStyle(
        fontSize: textFontSize,
        color: Colors.black,
      ),
      padding: const EdgeInsets.only(left: 10, top: 10),
      placeholder: hintText,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.top,
      placeholderStyle: TextStyle(
        fontSize: textFontSize,
        color: const Color(0xFFA8B0B8),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F6F8),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
