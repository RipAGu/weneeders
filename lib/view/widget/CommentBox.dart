import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String date;
  final String comment;

  const CommentBox({
    Key? key,
    this.imageUrl,
    required this.name,
    required this.date,
    required this.comment,
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
        ])
      ],
    );
  }
}
