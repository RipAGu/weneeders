class TestModel {
  final int idx;
  final String title;

  TestModel({
    required this.idx,
    required this.title,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      idx: json['idx'],
      title: json['title'],
    );
  }
}
