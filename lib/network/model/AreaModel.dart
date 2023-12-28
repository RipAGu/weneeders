class AreaModel {
  int idx;
  String name;
  bool isChecked = false;

  AreaModel({
    required this.idx,
    required this.name,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      idx: json['idx'],
      name: json['name'],
    );
  }

  @override
  String toString() {
    return 'AreaModel(idx: $idx, name: $name)';
  }
}
