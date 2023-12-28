import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:winit/network/model/ProjectListModel.dart';
import 'package:winit/network/model/ProjectRegisterModel.dart';

import '../../network/ApiService.dart';

class MainViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();

  final List<TestMainData> _mainDataList = [
    TestMainData(
        image: "assets/images/img.png",
        title: "인테리어 전문가",
        content: "방화문 필름 리폼(밀크화이트) 가격, 낮은 수납장 설치/ 센서 등은 매립으로 설치. 안녕하세요. 이...",
        writer: "홍길동",
        location: "서울",
        date: "2023.03.15 08:15"),
    TestMainData(
        image: "assets/images/img.png",
        title: "인테리어 전문가",
        content: "방화문 필름 리폼(밀크화이트) 가격, 낮은 수납장 설치/ 센서 등은 매립으로 설치. 안녕하세요. 이...",
        writer: "홍길동",
        location: "서울",
        date: "2023.03.15 08:15"),
    TestMainData(
        image: "assets/images/img.png",
        title: "인테리어 전문가",
        content: "방화문 필름 리폼(밀크화이트) 가격, 낮은 수납장 설치/ 센서 등은 매립으로 설치. 안녕하세요. 이...",
        writer: "홍길동",
        location: "서울",
        date: "2023.03.15 08:15"),
  ];
  List<TestMainData> get mainDataList => _mainDataList;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void changeTab(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> getProjectList() async {
    try {
      List<ProjectListModel> projectList = [];
      final response = await apiService.getProjectList();
      for (var item in response.data) {
        projectList.add(ProjectListModel.fromJson(item));
      }
      print(projectList);
    } catch (e) {
      print(e);
    }
  }

  Future<void> postProject() async {
    final Map<String, dynamic> body = {
      "startDate": "2021-10-10",
      "endDate": "2021-10-10",
      "methodType": 1,
      "fieldIdxList": [1, 2, 3],
      "depth2Idx": 1,
      "method": "1",
      "demandSkill": "1",
      "amount": "1",
      "imagePathList": null,
    };
    try {
      final response = await apiService.postProject(body);
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }

  Future<void> postPartner() async {
    final Map<String, dynamic> body = {
      "career": "1",
      "fieldIdxList": [1, 2, 3],
      "skillIdxList": [1, 2, 3],
      "method": "test",
      "depth2Idx": 1,
      "imgPathList": ["test"],
    };
    try {
      final response = await apiService.postPartner(body);
      print(response.statusCode);
    } on DioException catch (e) {
      print(e.response!.statusCode);
      print(e.response!.data['message']);
    }
  }
}

class TestMainData {
  final String image;
  late String title;
  final String content;
  final String writer;
  final String location;
  final String date;

  TestMainData({
    required this.image,
    required this.title,
    required this.content,
    required this.writer,
    required this.location,
    required this.date,
  });
}
