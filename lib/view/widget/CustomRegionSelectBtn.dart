import 'package:flutter/material.dart';
import 'package:winit/network/model/AreaModel.dart';
import 'package:winit/view/project/Register/AddViewModel.dart';

class CustomRegionSelectBtn extends StatelessWidget {
  final AreaModel region;
  final VoidCallback onTap;

  const CustomRegionSelectBtn({
    Key? key,
    required this.region,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          color:
              region.isChecked ? const Color(0xFF2D8CF4) : Colors.transparent,
          //bottom border
          border: const Border(
            bottom: BorderSide(
              color: Color(0xFFE7E7E7),
              width: 1,
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            region.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: region.isChecked ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
