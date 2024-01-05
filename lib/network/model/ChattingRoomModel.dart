class ChattingRoomModel {
  int idx;
  UserModel user;
  String curMessage;
  String curMessageTime;
  int messageCount;

  ChattingRoomModel(
      {required this.idx,
      required this.user,
      required this.curMessage,
      required this.curMessageTime,
      required this.messageCount});

  factory ChattingRoomModel.fromJson(Map<String, dynamic> json) {
    return ChattingRoomModel(
      idx: json['idx'],
      user: UserModel.fromJson(json['user']),
      curMessage: json['curMessage'],
      curMessageTime: json['curMessageTime'],
      messageCount: json['messageCount'],
    );
  }

  @override
  String toString() {
    return 'ChattingRoomModel{idx: $idx, user: $user, curMessage: $curMessage, curMessageTime: $curMessageTime, messageCount: $messageCount}';
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
