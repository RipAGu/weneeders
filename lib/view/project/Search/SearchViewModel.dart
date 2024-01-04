import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:winit/network/ApiService.dart';
import 'package:winit/network/model/ProjectListModel.dart';
import '../../../network/model/PartnerListModel.dart';

class SearchViewModel with ChangeNotifier {
  final ApiService apiService = ApiService();
  List<PartnerListModel> partnerList = [];
  List<ProjectListModel> projectList = [];
  bool _isLoadEnd = false;
  bool get isLoadEnd => _isLoadEnd;
  int _page = 1;
  late int userType; // 1: 업체, 2: 파트너, 3: 관리자

  Future<void> init() async {
    _page = 1;
    partnerList = [];
    projectList = [];
    _isLoadEnd = false;
    getPartnerList();
    getProjectList();
    await getUserInfo();
  }

  Future<void> getUserInfo() async {
    try {
      final response = await apiService.getUserInfo();
      userType = response.data['type'];
      print("userType : $userType");
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }

  Future<void> getPartnerList() async {
    try {
      final response = await apiService.getPartnerList(_page);
      if (response.statusCode == 200) {
        print(_page);
        if ((response.data as List).isEmpty) {
          print('데이터 없음');
          _isLoadEnd = true;
        } else {
          print('데이터 있음');
          for (var item in response.data) {
            DateTime date = DateTime.parse(item['createdAt']);
            String formattedDate =
                "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";
            item['createdAt'] = formattedDate;
            for (var img in item['PartnerImg']) {
              img['imgPath'] = "http://13.125.70.49" + img['imgPath'];
            }
            partnerList.add(PartnerListModel.fromJson(item));
          }
          _page++;
          notifyListeners();
        }
      }
    } on DioException catch (e) {
      _isLoadEnd = true;
      print(e.response!.data);
    }
  }

  Future<void> getProjectList() async {
    try {
      final response = await apiService.getProjectList(_page);
      if (response.statusCode == 200) {
        if ((response.data as List).isEmpty) {
          print('데이터 없음');
          _isLoadEnd = true;
        } else {
          print('데이터 있음');
          for (var item in response.data) {
            DateTime date = DateTime.parse(item['createdAt']);
            String formattedDate =
                "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";
            item['createdAt'] = formattedDate;
            for (var img in item['ProjectImg']) {
              img['imgPath'] = "http://13.125.70.49" + img['imgPath'];
            }
            projectList.add(ProjectListModel.fromJson(item));
          }
          _page++;
          notifyListeners();
        }
      }
    } on DioException catch (e) {
      _isLoadEnd = true;
      print(e.response!.data);
    }
  }
}
