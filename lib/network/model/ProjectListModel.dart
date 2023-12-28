class ProjectListModel {
  int idx;
  String method;
  String createdAt;
  Depth2RegionModel Depth2Region;
  UserModel User;
  List<PartnerSkillModel> PartnerSkillMapping;
  List<PartnerFieldModel> PartnerFieldMapping;
  List<ImgPathModel> ImagePath;

  ProjectListModel({
    required this.idx,
    required this.method,
    required this.createdAt,
    required this.Depth2Region,
    required this.User,
    required this.PartnerSkillMapping,
    required this.PartnerFieldMapping,
    required this.ImagePath,
  });

  factory ProjectListModel.fromJson(Map<String, dynamic> json) {
    return ProjectListModel(
      idx: json['idx'],
      method: json['method'],
      createdAt: json['createdAt'],
      Depth2Region: Depth2RegionModel.fromJson(json['Depth2Region']),
      User: UserModel.fromJson(json['User']),
      PartnerSkillMapping: (json['PartnerSkillMapping'] as List)
          .map((i) => PartnerSkillModel.fromJson(i))
          .toList(),
      PartnerFieldMapping: (json['PartnerFieldMapping'] as List)
          .map((i) => PartnerFieldModel.fromJson(i))
          .toList(),
      ImagePath: (json['ImagePath'] as List)
          .map((i) => ImgPathModel.fromJson(i))
          .toList(),
    );
  }
}

class Depth2RegionModel {
  String name;
  Depth1RegionModel Depth1Region;

  Depth2RegionModel({
    required this.name,
    required this.Depth1Region,
  });

  factory Depth2RegionModel.fromJson(Map<String, dynamic> json) {
    return Depth2RegionModel(
      name: json['name'],
      Depth1Region: Depth1RegionModel.fromJson(json['Depth1Region']),
    );
  }
}

class Depth1RegionModel {
  String name;
  Depth1RegionModel({
    required this.name,
  });

  factory Depth1RegionModel.fromJson(Map<String, dynamic> json) {
    return Depth1RegionModel(
      name: json['name'],
    );
  }
}

class UserModel {
  int idx;
  String nickname;
  String? profileImg;

  UserModel({
    required this.idx,
    required this.nickname,
    this.profileImg,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idx: json['idx'],
      nickname: json['nickname'],
      profileImg: json['profileImg'],
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
      name: json['name'],
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
      name: json['name'],
    );
  }
}

class ImgPathModel {
  String imgPath;
  ImgPathModel({
    required this.imgPath,
  });

  factory ImgPathModel.fromJson(Map<String, dynamic> json) {
    return ImgPathModel(
      imgPath: json['imgPath'],
    );
  }
}
