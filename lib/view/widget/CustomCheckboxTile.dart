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
        onTap: onTap,
        child: Row(
          children: [
            SvgPicture.asset(
              item.isChecked
                  ? 'assets/resources/circle_checked.svg'
                  : 'assets/resources/circle_unchecked.svg',
              width: 16,
              height: 16,
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
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
