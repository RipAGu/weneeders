import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String? image;
  final VoidCallback? onTap;

  const ImageBox({Key? key, this.image, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFF2F6F8),
            ),
            child: const Center(
                child: Icon(
              Icons.add,
              color: Color(0xff7D8791),
            ))),
      );
    } else {
      return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(image!),
                fit: BoxFit.cover,
              )));
    }
  }
}