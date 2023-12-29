import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:winit/network/ApiService.dart';
import 'package:winit/network/model/PartnerListModel.dart';
import '../../../network/model/ProjectDetailModel.dart';

class DetailViewModel with ChangeNotifier {
  final ApiService apiService = ApiService();
  late ProjectDetailModel projectDetailData;
  String projectField = "";
  String projectRegion = "";

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
    print(idx);
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
          "${projectDetailData.Depth2Region!.Depth1Region!.name} / ${projectDetailData.Depth2Region!.name}";
      print(projectRegion);
      notifyListeners();
      print(projectDetailData.startTime);
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> getProjectComment(int idx) async {
    try {
      final response = await ApiService().getProjectComment(idx);
      print(response.data);
    } on DioException catch (e) {
      print(e);
    }
  }

  void clearData() {
    projectRegion = "";
    print(projectRegion);
    projectField = "";
    projectDetailData = ProjectDetailModel(
        idx: 0,
        startTime: '',
        endTime: '',
        demandSkill: '',
        method: '',
        methodType: 0,
        createdAt: '',
        User: UserModel(idx: 0, name: ''),
        ProjectFieldMapping: [],
        Depth2Region: Depth2RegionModel(
            name: '', Depth1Region: Depth1RegionModel(name: '')),
        ProjectImg: [],
        loginUserProjectState: false);
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
