class PartnerListModel {
  int idx;
  String method;
  String createdAt;
  Depth2RegionModel Depth2Region;
  List<PartnerImgModel> PartnerImg;
  UserModel User;

  PartnerListModel({
    required this.idx,
    required this.method,
    required this.createdAt,
    required this.Depth2Region,
    required this.PartnerImg,
    required this.User,
  });

  factory PartnerListModel.fromJson(Map<String, dynamic> json) {
    return PartnerListModel(
      idx: json['idx'],
      method: json['method'],
      createdAt: json['createdAt'],
      Depth2Region: Depth2RegionModel.fromJson(json['Depth2Region']),
      PartnerImg: (json['PartnerImg'] as List)
          .map((item) => PartnerImgModel.fromJson(item))
          .toList(),
      User: UserModel.fromJson(json['User']),
    );
  }

  @override
  String toString() {
    return 'PartnerListModel(idx: $idx, method: $method, createdAt: $createdAt, Depth2Region: $Depth2Region, PartnerImg: $PartnerImg, User: $User)';
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

class PartnerImgModel {
  String img;

  PartnerImgModel({
    required this.img,
  });
  factory PartnerImgModel.fromJson(Map<String, dynamic> json) {
    return PartnerImgModel(
      img: json['imgPath'],
    );
  }
}

class UserModel {
  int idx;
  String name;

  UserModel({
    required this.idx,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idx: json['idx'],
      name: json['name'],
    );
  }
}
