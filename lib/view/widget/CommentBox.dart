import 'package:flutter/material.dart';
import 'package:winit/network/model/CommentModel.dart';
import 'package:winit/view/project/Detail/DetailViewModel.dart';

class CommentBox extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String date;
  final String comment;
  final List<ProjectReplyCommentModel> repleData;
  final Function repleOnTap;

  const CommentBox({
    Key? key,
    this.imageUrl,
    required this.name,
    required this.date,
    required this.comment,
    required this.repleData,
    required this.repleOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageUrl != null
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.07,
                    height: MediaQuery.of(context).size.width * 0.07,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(imageUrl!),
                    ),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width * 0.07,
                    height: MediaQuery.of(context).size.width * 0.07,
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/img.png'),
                    ),
                  ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 5)),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7D8690),
                    ),
                  ),
                ],
              ),
              Text(
                comment,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7D8690),
                ),
              ),
            ])
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          color: const Color(0xFFF2F2F2),
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: repleData.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        repleData[index].User.profileImg != null
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width * 0.07,
                                height:
                                    MediaQuery.of(context).size.width * 0.07,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(imageUrl!),
                                ),
                              )
                            : SizedBox(
                                width: MediaQuery.of(context).size.width * 0.07,
                                height:
                                    MediaQuery.of(context).size.width * 0.07,
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage('assets/images/img.png'),
                                ),
                              ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    repleData[index].User.nickname,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 5)),
                                  Text(
                                    repleData[index].createdAt,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF7D8690),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                repleData[index].contents,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF7D8690),
                                ),
                              ),
                            ])
                      ],
                    ));
              },
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            repleOnTap();
          },
          child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: const Padding(
                  padding: EdgeInsets.only(left: 38),
                  child: Text(
                    "답글 달기",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF7D8690),
                    ),
                  ))),
        ),
      ],
    );
  }
}
