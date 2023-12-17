import 'package:flutter/material.dart';

import '../project/DetailViewModel.dart';

class CommentBox extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String date;
  final String comment;
  final List<CommentData> repleData;

  const CommentBox({
    Key? key,
    this.imageUrl,
    required this.name,
    required this.date,
    required this.comment,
    required this.repleData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: repleData.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        repleData[index].imageUrl != null
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
                                width: MediaQuery.of(context).size.width * 0.05,
                                height:
                                    MediaQuery.of(context).size.width * 0.05,
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
                                    repleData[index].name,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 5)),
                                  Text(
                                    repleData[index].date,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF7D8690),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                repleData[index].comment,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF7D8690),
                                ),
                              ),
                            ])
                      ],
                    ));
              },
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              "답글 달기",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF7D8690),
              ),
            ),
          ),
        ])
      ],
    );
  }
}
