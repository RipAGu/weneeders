class SkillDataDetailModel {
  int idx;
  String title;
  String thumbnailImgPath;
  String videoPath;
  String createdAt;
  UserModel User;

  SkillDataDetailModel(
      {required this.idx,
      required this.title,
      required this.thumbnailImgPath,
      required this.videoPath,
      required this.createdAt,
      required this.User});

  factory SkillDataDetailModel.fromJson(Map<String, dynamic> json) {
    return SkillDataDetailModel(
      idx: json['idx'],
      title: json['title'],
      thumbnailImgPath: json['thumbnailImgPath'],
      videoPath: json['videoPath'],
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
