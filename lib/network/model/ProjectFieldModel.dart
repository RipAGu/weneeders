class ProjectFieldModel {
  int idx;
  String name;

  ProjectFieldModel({
    required this.idx,
    required this.name,
  });

  factory ProjectFieldModel.fromJson(Map<String, dynamic> json) {
    return ProjectFieldModel(
      idx: json['idx'],
      name: json['name'],
    );
  }
}
