import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MainAppBar({Key? key, required this.title}) : super(key: key);

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
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      leadingWidth: 70,
      leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
              onPressed: null,
              icon: SvgPicture.asset("assets/icons/icon_profile.svg"))),
      title: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
                onPressed: null,
                icon: SvgPicture.asset("assets/icons/menu.svg")))
      ],
    );
  }
}
