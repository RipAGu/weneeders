import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:winit/network/model/ProjectListModel.dart';
import '../../network/ApiService.dart';
import '../../network/model/PartnerListModel.dart';

class MainViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();
  List<PartnerListModel> partnerList = [];
  List<ProjectListModel> projectList = [];

  MainViewModel() {
    getPartnerList();
    getProjectList();
  }

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
    int count = 0;
    try {
      final response = await apiService.getProjectList(1);
      for (var item in response.data) {
        if (count >= 3) break;
        projectList.add(ProjectListModel.fromJson(item));
      }
      print(projectList);
      notifyListeners();
    } on DioException catch (e) {
      print(e.response!.statusCode);
      print(e.response!.data['message']);
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

  Future<void> getPartnerList() async {
    int count = 0;
    try {
      final response = await apiService.getPartnerList(1);
      for (var item in response.data) {
        if (count >= 3) break;
        DateTime date = DateTime.parse(item['createdAt']);
        String formattedDate =
            "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";
        item['createdAt'] = formattedDate;
        partnerList.add(PartnerListModel.fromJson(item));
        count++;
      }
      notifyListeners();
    } on DioException catch (e) {
      print(e.response!.statusCode);
      print(e.response!.data['message']);
    }
  }
}
