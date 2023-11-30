import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCheckBoxGray extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final String checkedBlack = 'assets/icons/checked_gray.svg';
  final String uncheckedBlack = 'assets/icons/unchecked_gray.svg';

  const CustomCheckBoxGray({
    Key? key,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isChecked);
      },
      child: isChecked
          ? SvgPicture.asset(checkedBlack)
          : SvgPicture.asset(uncheckedBlack),
    );
  }
}
