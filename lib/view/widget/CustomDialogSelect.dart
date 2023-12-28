import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogSelect extends StatelessWidget {
  String title;
  String content;
  String cancelText;
  String confirmText;
  Function() cancelPressed;
  Function() confirmPressed;

  CustomDialogSelect({
    required this.title,
    required this.content,
    required this.cancelText,
    required this.confirmText,
    required this.cancelPressed,
    required this.confirmPressed,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      backgroundColor: Colors.white,
      content: Text(content),
      actions: [
        TextButton(
          onPressed: cancelPressed,
          child: Text(cancelText, style: const TextStyle(color: Colors.black)),
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
          ),
        ),
        TextButton(
            onPressed: confirmPressed,
            child:
                Text(confirmText, style: const TextStyle(color: Colors.black)),
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            )),
      ],
    );
  }
}
