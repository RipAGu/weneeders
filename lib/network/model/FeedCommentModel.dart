class FeedCommentModel {
  int idx;
  String contents;
  bool myCommentState;
  String createdAt;
  UserModel user;
  List<ReplyCommentModel> replyCommentList;

  FeedCommentModel({
    required this.idx,
    required this.contents,
    required this.myCommentState,
    required this.createdAt,
    required this.user,
    required this.replyCommentList,
  });

  factory FeedCommentModel.fromJson(Map<String, dynamic> json) {
    return FeedCommentModel(
      idx: json['idx'],
      contents: json['contents'],
      myCommentState: json['myReplyCommentState'],
      createdAt: json['createdAt'],
      user: UserModel.fromJson(json['user']),
      replyCommentList: json['replyCommentList']
          .map<ReplyCommentModel>((e) => ReplyCommentModel.fromJson(e))
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

class ReplyCommentModel {
  int idx;
  String contents;
  bool myReplyCommentState;
  String createdAt;
  UserModel user;

  ReplyCommentModel({
    required this.idx,
    required this.contents,
    required this.myReplyCommentState,
    required this.createdAt,
    required this.user,
  });

  factory ReplyCommentModel.fromJson(Map<String, dynamic> json) {
    return ReplyCommentModel(
      idx: json['idx'],
      contents: json['contents'],
      myReplyCommentState: json['myReplyCommentState'],
      createdAt: json['createdAt'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
