import 'package:flutter/cupertino.dart';

class ImageBox extends StatelessWidget {
  final String image;

  const ImageBox({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ));
  }
}
