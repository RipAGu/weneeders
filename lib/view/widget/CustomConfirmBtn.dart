import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomConfirmBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double textSize;

  const CustomConfirmBtn({
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
          borderRadius: BorderRadius.circular(5),
        ),
      ).copyWith(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.transparent; // 비활성화 상태일 때 투명 처리
            }
            return null; // 기본값으로 설정 (물결 효과 유지)
          },
        ),
      ),
      child: Text(text,
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
          )),
    );
  }
}
