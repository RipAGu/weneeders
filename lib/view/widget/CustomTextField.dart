import 'package:flutter/cupertino.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool? isEditable;
  final double textFontSize;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.keyboardType,
    this.isEditable,
    required this.textFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      style: TextStyle(
        fontSize: textFontSize,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      placeholder: hintText,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      enabled: isEditable != null ? false : true,
      placeholderStyle: const TextStyle(fontSize: 12, color: Color(0xFFA8B0B8)),
      decoration: BoxDecoration(
        color: const Color(0x00ffffff),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: const Color(0xffa9b0b8),
          width: 1,
        ),
      ),
    );
  }
}
