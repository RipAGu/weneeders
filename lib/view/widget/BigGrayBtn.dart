import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BigGrayBtn extends StatelessWidget {
  final String image;
  final String text;
  //textcolor
  final Color? textColor;
  final double fontSize;
  final VoidCallback? onPressed;

  const BigGrayBtn({
    Key? key,
    required this.text,
    required this.textColor,
    required this.fontSize,
    required this.image,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
            padding: const EdgeInsets.only(top: 9, bottom: 9, left: 10),
            decoration: ShapeDecoration(
                color: Color(0xfff6f6f6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                shadows: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 1,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  )
                ]),
            child: Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 10)),
                SvgPicture.asset(
                  image,
                  colorFilter: const ColorFilter.mode(
                      Color(0xff2D8DF4), BlendMode.srcIn),
                ),
                const Padding(padding: EdgeInsets.only(left: 10)),
                Text(
                  text,
                  style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                      fontFamily: 'Source_Sans_Pro'),
                )
              ],
            )));
  }
}
