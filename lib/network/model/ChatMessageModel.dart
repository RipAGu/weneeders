class ChatMessageModel {
  int idx;
  String message;
  bool myMessageState;
  String createdAt;
  String? type; //1. receive 2. send 3. date

  ChatMessageModel(
      {required this.idx,
      required this.message,
      required this.myMessageState,
      required this.createdAt,
      this.type});

  ChatMessageModel.fromJson(Map<String, dynamic> json)
      : idx = json['idx'],
        message = json['message'],
        myMessageState = json['myMessageState'],
        createdAt = json['createdAt'],
        type = json['type'];

  @override
  String toString() {
    return 'ChatMessageModel{idx: $idx, message: $message, myMessageState: $myMessageState, createdAt: $createdAt, type: $type}';
  }
}
