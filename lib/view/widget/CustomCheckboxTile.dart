import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCheckboxTile extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;

  const CustomCheckboxTile({Key? key, required this.item, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Row(
          children: [
            SvgPicture.asset(
              item.isChecked
                  ? 'assets/icons/checked_blue.svg'
                  : 'assets/icons/unchecked_gray.svg',
            ),
            const Padding(padding: EdgeInsets.only(left: 5)),
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ));
  }
}

class Item {
  String title;
  bool isChecked;

  Item({required this.title, required this.isChecked});
}
