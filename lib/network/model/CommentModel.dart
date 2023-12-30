class ProjectCommentModel {
  int idx;
  String createdAt;
  String contents;
  UserModel User;
  List<ProjectReplyCommentModel> ProjectReplyComment;

  ProjectCommentModel({
    required this.idx,
    required this.createdAt,
    required this.contents,
    required this.User,
    required this.ProjectReplyComment,
  });

  factory ProjectCommentModel.fromJson(Map<String, dynamic> json) {
    return ProjectCommentModel(
      idx: json['idx'],
      createdAt: json['createdAt'],
      contents: json['contents'],
      User: UserModel.fromJson(json['User']),
      ProjectReplyComment: json['ProjectReplyComment']
          .map<ProjectReplyCommentModel>(
              (e) => ProjectReplyCommentModel.fromJson(e))
          .toList(),
    );
  }
}

class PartnerCommentModel {
  int idx;
  String createdAt;
  String contents;
  UserModel User;
  List<ProjectReplyCommentModel> PartnerReplyComment;

  PartnerCommentModel({
    required this.idx,
    required this.createdAt,
    required this.contents,
    required this.User,
    required this.PartnerReplyComment,
  });

  factory PartnerCommentModel.fromJson(Map<String, dynamic> json) {
    return PartnerCommentModel(
      idx: json['idx'],
      createdAt: json['createdAt'],
      contents: json['contents'],
      User: UserModel.fromJson(json['User']),
      PartnerReplyComment: json['PartnerReplyComment']
          .map<ProjectReplyCommentModel>(
              (e) => ProjectReplyCommentModel.fromJson(e))
          .toList(),
    );
  }
}

class UserModel {
  int idx;
  String nickname;
  String? profileImg;

  UserModel({
    required this.idx,
    required this.nickname,
    required this.profileImg,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idx: json['idx'],
      nickname: json['nickname'],
      profileImg: json['profileImg'],
    );
  }
}

class ProjectReplyCommentModel {
  int idx;
  String contents;
  String createdAt;
  UserModel User;

  ProjectReplyCommentModel({
    required this.idx,
    required this.contents,
    required this.createdAt,
    required this.User,
  });

  factory ProjectReplyCommentModel.fromJson(Map<String, dynamic> json) {
    return ProjectReplyCommentModel(
      idx: json['idx'],
      contents: json['contents'],
      createdAt: json['createdAt'],
      User: UserModel.fromJson(json['User']),
    );
  }
}
