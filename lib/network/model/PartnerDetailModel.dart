import 'package:winit/network/model/PartnerListModel.dart';

class PartnerDetailModel {
  int idx;
  String career;
  String method;
  String createdAt;
  Depth2RegionModel Depth2Region;
  List<PartnerImgModel> PartnerImg;
  List<PartnerFieldModel> PartnerFieldMapping;
  List<PartnerSkillModel> PartnerSkillMapping;
  UserModel User;
  bool loginUserPartnerState;

  PartnerDetailModel({
    required this.idx,
    required this.career,
    required this.method,
    required this.createdAt,
    required this.Depth2Region,
    required this.PartnerImg,
    required this.PartnerFieldMapping,
    required this.PartnerSkillMapping,
    required this.User,
    required this.loginUserPartnerState,
  });

  factory PartnerDetailModel.fromJson(Map<String, dynamic> json) {
    return PartnerDetailModel(
      idx: json['idx'],
      career: json['career'],
      method: json['method'],
      createdAt: json['createdAt'],
      Depth2Region: Depth2RegionModel.fromJson(json['Depth2Region']),
      PartnerImg: (json['PartnerImg'] as List)
          .map((i) => PartnerImgModel.fromJson(i))
          .toList(),
      PartnerFieldMapping: (json['PartnerFieldMapping'] as List)
          .map((i) => PartnerFieldModel.fromJson(i))
          .toList(),
      PartnerSkillMapping: (json['PartnerSkillMapping'] as List)
          .map((i) => PartnerSkillModel.fromJson(i))
          .toList(),
      User: UserModel.fromJson(json['User']),
      loginUserPartnerState: json['loginUserPartnerState'],
    );
  }
}

class PartnerFieldModel {
  String name;

  PartnerFieldModel({
    required this.name,
  });

  factory PartnerFieldModel.fromJson(Map<String, dynamic> json) {
    return PartnerFieldModel(
      name: json['PartnerField']['name'],
    );
  }
}

class PartnerSkillModel {
  String name;

  PartnerSkillModel({
    required this.name,
  });

  factory PartnerSkillModel.fromJson(Map<String, dynamic> json) {
    return PartnerSkillModel(
      name: json['PartnerSkill']['name'],
    );
  }
}
