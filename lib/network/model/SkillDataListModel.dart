class SkillDataListModel {
  int idx;
  String title;
  String thumbnailImgPath;
  String createdAt;
  UserModel User;

  SkillDataListModel(
      {required this.idx,
      required this.title,
      required this.createdAt,
      required this.thumbnailImgPath,
      required this.User});

  factory SkillDataListModel.fromJson(Map<String, dynamic> json) {
    return SkillDataListModel(
      idx: json['idx'],
      title: json['title'],
      thumbnailImgPath: json['thumbnailImgPath'],
      createdAt: json['createdAt'],
      User: UserModel.fromJson(json['User']),
    );
  }
}

class UserModel {
  int idx;
  String nickname;

  UserModel({required this.idx, required this.nickname});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idx: json['idx'],
      nickname: json['nickname'],
    );
  }
}
