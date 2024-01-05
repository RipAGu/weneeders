import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TitleOnlyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleOnlyAppBar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: Colors.grey[300],
          height: 1,
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      ),
      elevation: 0,
      leading: const Padding(
        padding: EdgeInsets.only(left: 0),
      ),
      leadingWidth: 0,
      surfaceTintColor: Colors.transparent,
      title: Center(
          child: Text(title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ))),
    );
  }
}
