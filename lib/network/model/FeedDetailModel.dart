class FeedDetailModel {
  int idx;
  String title;
  String contents;
  List<String> imgList;
  String createdAt;
  bool myFeedState;
  UserModel user;

  FeedDetailModel({
    required this.idx,
    required this.title,
    required this.contents,
    required this.imgList,
    required this.createdAt,
    required this.myFeedState,
    required this.user,
  });

  factory FeedDetailModel.fromJson(Map<String, dynamic> json) {
    return FeedDetailModel(
      idx: json['idx'],
      title: json['title'],
      contents: json['contents'],
      imgList: json['imgList'].cast<String>(),
      createdAt: json['createdAt'],
      myFeedState: json['myFeedState'],
      user: UserModel.fromJson(json['user']),
    );
  }
}

class UserModel {
  int idx;
  String nickname;

  UserModel({
    required this.idx,
    required this.nickname,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idx: json['idx'],
      nickname: json['nickname'],
    );
  }
}
