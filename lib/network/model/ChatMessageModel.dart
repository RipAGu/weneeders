class ChatMessageModel {
  int idx;
  String message;
  bool myMessageState;
  String createdAt;
  String type = "receive"; //1. receive 2. send 3. date

  ChatMessageModel({
    required this.idx,
    required this.message,
    required this.myMessageState,
    required this.createdAt,
  });

  ChatMessageModel.fromJson(Map<String, dynamic> json)
      : idx = json['idx'],
        message = json['message'],
        myMessageState = json['myMessageState'],
        createdAt = json['createdAt'];
}
