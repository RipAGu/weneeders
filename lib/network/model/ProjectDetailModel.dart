import 'package:winit/network/model/PartnerListModel.dart';

class ProjectDetailModel {
  int idx;
  String startTime;
  String endTime;
  String demandSkill;
  String method;
  int methodType;
  String createdAt;
  UserModel User;
  List<ProjectFieldModel> ProjectFieldMapping;
  Depth2RegionModel Depth2Region;
  List<String> ProjectImg;
  bool loginUserProjectState;

  ProjectDetailModel({
    required this.idx,
    required this.startTime,
    required this.endTime,
    required this.demandSkill,
    required this.method,
    required this.methodType,
    required this.createdAt,
    required this.User,
    required this.ProjectFieldMapping,
    required this.Depth2Region,
    required this.ProjectImg,
    required this.loginUserProjectState,
  });

  factory ProjectDetailModel.fromJson(Map<String, dynamic> json) {
    return ProjectDetailModel(
      idx: json['idx'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      demandSkill: json['demandSkill'],
      method: json['method'],
      methodType: json['methodType'],
      createdAt: json['createdAt'],
      User: UserModel.fromJson(json['User']),
      ProjectFieldMapping: (json['ProjectFieldMapping'] as List)
          .map((i) => ProjectFieldModel.fromJson(i))
          .toList(),
      Depth2Region: Depth2RegionModel.fromJson(json['Depth2Region']),
      ProjectImg:
          (json['ProjectImg'] as List).map((i) => i.toString()).toList(),
      loginUserProjectState: json['loginUserProjectState'],
    );
  }
}

class ProjectFieldModel {
  String name;

  ProjectFieldModel({
    required this.name,
  });

  factory ProjectFieldModel.fromJson(Map<String, dynamic> json) {
    return ProjectFieldModel(
      name: json['ProjectField']['name'],
    );
  }
}
