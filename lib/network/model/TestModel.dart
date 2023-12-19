class TestModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  TestModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
