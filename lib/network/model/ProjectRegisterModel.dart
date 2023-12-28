class ProjectRegisterModel {
  String startDate;
  String endDate;
  int methodType;
  List<int> fieldIdxList;
  int depth2Idx;
  String method;
  String demandSkill;
  String amount;
  List<String>? imagePathList;

  ProjectRegisterModel({
    required this.startDate,
    required this.endDate,
    required this.methodType,
    required this.fieldIdxList,
    required this.depth2Idx,
    required this.method,
    required this.demandSkill,
    required this.amount,
    this.imagePathList,
  });

  factory ProjectRegisterModel.fromJson(Map<String, dynamic> json) {
    return ProjectRegisterModel(
      startDate: json['startDate'],
      endDate: json['endDate'],
      methodType: json['methodType'],
      fieldIdxList: json['fieldIdxList'],
      depth2Idx: json['depth2Idx'],
      method: json['method'],
      demandSkill: json['demandSkill'],
      amount: json['amount'],
      imagePathList: json['imagePathList'],
    );
  }
}
