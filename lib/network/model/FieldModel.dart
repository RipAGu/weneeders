class FieldModel {
  int idx;
  String name;
  bool isChecked = false;

  FieldModel({
    required this.idx,
    required this.name,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      idx: json['idx'],
      name: json['name'],
    );
  }

  @override
  String toString() {
    return 'AreaModel(idx: $idx, name: $name)';
  }
}
