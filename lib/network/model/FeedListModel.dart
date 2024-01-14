class FeedListModel {
  int idx;
  String title;
  String contents;
  String? thumbnail;
  String createdAt;
  UserModel user;

  FeedListModel({
    required this.idx,
    required this.title,
    required this.contents,
    this.thumbnail,
    required this.createdAt,
    required this.user,
  });

  factory FeedListModel.fromJson(Map<String, dynamic> json) {
    return FeedListModel(
      idx: json['idx'],
      title: json['title'],
      contents: json['contents'],
      thumbnail: json['thumbnail'],
      createdAt: json['createdAt'],
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
