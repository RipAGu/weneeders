import 'package:flutter/cupertino.dart';

class DetailViewModel with ChangeNotifier {
  final List<CommentData> testCommentList = [
    CommentData(name: "홍길동", date: "2일전", comment: "너무 멋있어요!"),
    CommentData(name: "홍길동", date: "3일전", comment: "최고에요!"),
  ];

  final List<List<CommentData>> testRepleData = [
    [],
    [
      CommentData(name: "홍길동", date: "2일전", comment: "너무 멋있어요!"),
      CommentData(name: "홍길동", date: "3일전", comment: "최고에요!")
    ],
  ];

  final List<String> images = [
    "assets/images/img.png",
    "assets/images/img.png",
    "assets/images/img.png",
    "assets/images/img.png",
  ];
}

class CommentData {
  final String? imageUrl;
  final String name;
  final String date;
  final String comment;

  CommentData({
    this.imageUrl,
    required this.name,
    required this.date,
    required this.comment,
  });
}
