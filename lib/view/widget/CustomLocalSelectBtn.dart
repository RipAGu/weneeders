import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winit/view/project/Register/AddViewModel.dart';

class CustomLocalSelectBtn extends StatelessWidget {
  final LocalData local;
  final VoidCallback onTap;

  const CustomLocalSelectBtn({
    Key? key,
    required this.local,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: local.isChecked
                ? const Color(0xFF2D8CF4)
                : const Color(0xFFF2F6F8),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              local.title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: local.isChecked ? Colors.white : Colors.black,
              ),
            ),
          ),
        ));
  }
}
