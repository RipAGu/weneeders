import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogConfirm extends StatelessWidget {
  String title;
  String content;
  String confirmText;
  Function() confirmPressed;

  CustomDialogConfirm({
    super.key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.confirmPressed,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: confirmPressed,
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child:
                Text(confirmText, style: const TextStyle(color: Colors.black))),
      ],
    );
  }
}
