import 'package:flutter/cupertino.dart';

class ProjectData {
  final String image;
  late String title;
  final String writer;
  final String date;
  final String location;
  final String content;

  ProjectData({
    required this.image,
    required this.title,
    required this.writer,
    required this.date,
    required this.location,
    required this.content,
  });
}

class ProjectCard extends StatelessWidget {
  final String image;
  final String title;
  final String writer;
  final String date;
  final String location;
  final String content;
  final VoidCallback? onPressed;

  const ProjectCard({
    Key? key,
    required this.image,
    required this.title,
    required this.writer,
    required this.date,
    required this.location,
    required this.content,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent, // 비어있는 공간에도 ontap이 작동하도록 하는 설정
        onTap: onPressed,
        child: Row(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 11)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(
                        text: "제목: ",
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xff000000),
                        )),
                    TextSpan(
                        text: title,
                        style: const TextStyle(
                            color: Color(0xff000000),
                            fontSize: 10,
                            fontWeight: FontWeight.w700))
                  ]),
                  overflow: TextOverflow.ellipsis,
                ),
                const Padding(padding: EdgeInsets.only(top: 2)),
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
                    const TextSpan(
                        text: "지역: ",
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xff000000),
                        )),
                    TextSpan(
                        text: location,
                        style: const TextStyle(
                            color: Color(0xff000000),
                            fontSize: 10,
                            fontWeight: FontWeight.w700))
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
