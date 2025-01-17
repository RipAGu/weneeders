import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuOnlyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MenuOnlyAppBar({Key? key, required this.title}) : super(key: key);
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
      surfaceTintColor: Colors.transparent,
      leadingWidth: 65,
      leading:
          Padding(padding: const EdgeInsets.only(left: 10), child: Container()),
      title: Center(
          child: Text(title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ))),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: SvgPicture.asset("assets/icons/menu.svg")))
      ],
    );
  }
}
