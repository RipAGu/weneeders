import 'package:flutter/cupertino.dart';

class DataSkillCard extends StatelessWidget {
  final String? image;
  final String writer;
  final String date;
  final String content;
  final VoidCallback? onPressed;

  const DataSkillCard({
    Key? key,
    required this.image,
    required this.writer,
    required this.date,
    required this.content,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent, // 이벤트가 발생하는 영역을 확장
        onTap: onPressed,
        child: Row(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: image == null
                    ? const Image(
                        image: AssetImage('assets/images/img.png'),
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        image!,
                        fit: BoxFit.cover,
                      )),
          ),
          const Padding(padding: EdgeInsets.only(left: 11)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(
                        text: "작성자: ",
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xff000000),
                        )),
                    TextSpan(
                        text: "$writer ",
                        style: const TextStyle(
                            color: Color(0xff000000),
                            fontSize: 10,
                            fontWeight: FontWeight.w700)),
                  ]),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  date,
                  style: const TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
                const Padding(padding: EdgeInsets.only(top: 2)),
                Text(
                  content,
                  style: const TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ]));
  }
}
