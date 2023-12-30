import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:winit/network/ApiService.dart';
import 'package:winit/network/model/CommentModel.dart';
import 'package:winit/network/model/PartnerDetailModel.dart';
import 'package:winit/network/model/PartnerListModel.dart' as partner;
import '../../../network/model/ProjectDetailModel.dart';

class DetailViewModel with ChangeNotifier {
  final ApiService apiService = ApiService();
  List<ProjectCommentModel> projectCommentList = [];
  List<PartnerCommentModel> partnerCommentList = [];
  late ProjectDetailModel projectDetailData;
  late PartnerDetailModel partnerDetailData;
  String projectField = "";
  String projectRegion = "";
  String partnerField = "";
  String partnerSkill = "";
  String partnerRegion = "";
  bool isRepleOn = false;
  int repleIndex = 0;

  final List<CommentData> testCommentList = [
    CommentData(name: "홍길동", date: "2일전", comment: "너무 멋있어요!"),
    CommentData(name: "홍길동", date: "3일전", comment: "최고에요!"),
  ];

  final List<List<CommentData>> testRepleData = [
    [],
    [
      CommentData(name: "홍길동", date: "2일전", comment: "너무 멋있어요!"),
      CommentData(name: "홍길동", date: "3일전", comment: "최고에요!")
    ],
  ];

  final List<String> images = [
    "assets/images/img.png",
    "assets/images/img.png",
    "assets/images/img.png",
    "assets/images/img.png",
  ];

  Future<void> getProjectDetail(int idx) async {
    projectRegion = "";
    projectField = "";
    try {
      final response = await ApiService().getProjectDetail(idx);
      projectDetailData = ProjectDetailModel.fromJson(response.data);
      //2023-12-31T15:00:00.000Z 형식을 2023-12-31 형식으로 바꿔줌
      projectDetailData.createdAt = projectDetailData.createdAt.split("T")[0];
      projectDetailData.startTime = projectDetailData.startTime.split("T")[0];
      projectDetailData.endTime = projectDetailData.endTime.split("T")[0];
      for (int i = 0; i < projectDetailData.ProjectFieldMapping!.length; i++) {
        projectField += projectDetailData.ProjectFieldMapping![i].name;
        if (i != projectDetailData.ProjectFieldMapping!.length - 1) {
          projectField += ", ";
        }
      }
      projectRegion +=
          "${projectDetailData.Depth2Region!.Depth1Region!.name} - ${projectDetailData.Depth2Region!.name}";
      notifyListeners();
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> getProjectComment(int idx) async {
    projectCommentList = [];
    try {
      final response = await ApiService().getProjectComment(idx);
      projectCommentList = (response.data as List)
          .map((i) => ProjectCommentModel.fromJson(i))
          .toList();
      for (int i = 0; i < projectCommentList.length; i++) {
        //월 일 추출
        String month = projectCommentList[i].createdAt.split("-")[1];
        String day =
            projectCommentList[i].createdAt.split("-")[2].split("T")[0];
        projectCommentList[i].createdAt = "$month월$day일";
        for (int j = 0;
            j < projectCommentList[i].ProjectReplyComment.length;
            j++) {
          String month = projectCommentList[i]
              .ProjectReplyComment[j]
              .createdAt
              .split("-")[1];
          String day = projectCommentList[i]
              .ProjectReplyComment[j]
              .createdAt
              .split("-")[2]
              .split("T")[0];
          projectCommentList[i].ProjectReplyComment[j].createdAt =
              "$month월$day일";
        }
      }
      notifyListeners();
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> postProjectComment(int idx, String contents) async {
    try {
      final response = await ApiService().postProjectComment(idx, contents);
      getProjectComment(idx);
      print(response.data);
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> postProjectRepleComment(int projectIdx, String contents) async {
    try {
      final response =
          await ApiService().postProjectRepleComment(repleIndex, contents);
      getProjectComment(projectIdx);
      print(response.data);
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> getPartnerDetail(int idx) async {
    partnerRegion = "";
    partnerField = "";
    partnerSkill = "";
    try {
      final response = await apiService.getPartnerDetail(idx);
      partnerDetailData = PartnerDetailModel.fromJson(response.data);
      //2023-12-31T15:00:00.000Z 형식을 2023-12-31 형식으로 바꿔줌
      partnerDetailData.createdAt = partnerDetailData.createdAt.split("T")[0];
      for (int i = 0; i < partnerDetailData.PartnerFieldMapping!.length; i++) {
        partnerField += partnerDetailData.PartnerFieldMapping![i].name;
        if (i != partnerDetailData.PartnerFieldMapping!.length - 1) {
          partnerField += ", ";
        }
      }
      for (int i = 0; i < partnerDetailData.PartnerSkillMapping!.length; i++) {
        partnerSkill += partnerDetailData.PartnerSkillMapping![i].name;
        if (i != partnerDetailData.PartnerSkillMapping!.length - 1) {
          partnerSkill += ", ";
        }
      }
      partnerRegion +=
          "${partnerDetailData.Depth2Region!.Depth1Region!.name} - ${partnerDetailData.Depth2Region!.name}";
      notifyListeners();
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> getPartnerComment(int idx) async {
    partnerCommentList = [];
    try {
      final response = await ApiService().getPartnerComment(idx);
      partnerCommentList = (response.data as List)
          .map((i) => PartnerCommentModel.fromJson(i))
          .toList();
      for (int i = 0; i < partnerCommentList.length; i++) {
        //월 일 추출
        String month = partnerCommentList[i].createdAt.split("-")[1];
        String day =
            partnerCommentList[i].createdAt.split("-")[2].split("T")[0];
        partnerCommentList[i].createdAt = "$month월$day일";
        for (int j = 0;
            j < partnerCommentList[i].PartnerReplyComment.length;
            j++) {
          String month = partnerCommentList[i]
              .PartnerReplyComment[j]
              .createdAt
              .split("-")[1];
          String day = partnerCommentList[i]
              .PartnerReplyComment[j]
              .createdAt
              .split("-")[2]
              .split("T")[0];
          partnerCommentList[i].PartnerReplyComment[j].createdAt =
              "$month월$day일";
        }
      }
      notifyListeners();
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> postPartnerComment(int idx, String contents) async {
    try {
      final response = await ApiService().postPartnerComment(idx, contents);
      getPartnerComment(idx);
      print(response.data);
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> postPartnerRepleComment(int partnerIdx, String contents) async {
    try {
      final response =
          await ApiService().postPartnerRepleComment(repleIndex, contents);
      getPartnerComment(partnerIdx);
      print(response.data);
    } on DioException catch (e) {
      print(e);
    }
  }

  void clearData() {
    projectRegion = "";
    projectField = "";
    projectDetailData = ProjectDetailModel(
        idx: 0,
        startTime: '',
        endTime: '',
        demandSkill: '',
        method: '',
        methodType: 0,
        createdAt: '',
        User: partner.UserModel(idx: 1, name: ""),
        ProjectFieldMapping: [],
        Depth2Region: partner.Depth2RegionModel(
            name: '', Depth1Region: partner.Depth1RegionModel(name: '')),
        ProjectImg: [],
        loginUserProjectState: false);
  }

  void setRepleOn(int idx) {
    print("on");
    isRepleOn = true;
    repleIndex = idx;
  }

  void setRepleOff() {
    print("off");
    isRepleOn = false;
  }
}

class CommentData {
  final String? imageUrl;
  final String name;
  final String date;
  final String comment;

  CommentData({
    this.imageUrl,
    required this.name,
    required this.date,
    required this.comment,
  });
}
