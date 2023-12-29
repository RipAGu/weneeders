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

  void init() {
    _page = 1;
    partnerList = [];
    projectList = [];
    _isLoadEnd = false;
    getPartnerList();
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
          print(response.data as List);
          for (var item in response.data) {
            DateTime date = DateTime.parse(item['createdAt']);
            String formattedDate =
                "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";
            item['createdAt'] = formattedDate;
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
          print(response.data as List);
          for (var item in response.data) {
            DateTime date = DateTime.parse(item['createdAt']);
            String formattedDate =
                "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";
            item['createdAt'] = formattedDate;
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
