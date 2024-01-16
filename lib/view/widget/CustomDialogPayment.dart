import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogPayment extends StatelessWidget {
  final TextEditingController controller;

  CustomDialogPayment({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              "송금",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 16),
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          //구분선
          height: 1,
          color: const Color(0xFFe8e8e8),
        ),
        // 공사금액 입력
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: TextField(
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0.0, color: Colors.transparent),
                    ),
                    hintText: "공사금액을 입력해주세요.",
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFA8B0B8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0.0, color: Colors.transparent),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const Text(
                "원",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            //취소 확인 버튼
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: const Color(0xFFF4F6F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "취소",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, controller.text);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF2D8DF4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "확인",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
