import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:winit/network/ApiService.dart';
import 'package:winit/network/model/AreaModel.dart';
import 'package:winit/network/model/FieldModel.dart';
import 'package:winit/network/model/ProjectListModel.dart';
import '../../../network/model/PartnerListModel.dart';

class SearchViewModel with ChangeNotifier {
  final ApiService apiService = ApiService();
  List<PartnerListModel> partnerList = [];
  List<ProjectListModel> projectList = [];
  List<FieldModel> projectFieldList = [];

  List<FieldModel> partnerFieldList = [];
  List<FieldModel> partnerSkillList = [];
  List<AreaModel> area1List = [];
  List<AreaModel> area2List = [];
  bool _isLoadEnd = false;
  bool get isLoadEnd => _isLoadEnd;
  int page = 1;

  int? filterIdx;
  String? filterName;
  late int userType; // 1: 업체, 2: 파트너, 3: 관리자

  Future<void> init() async {
    page = 1;
    partnerList = [];
    projectList = [];
    filterIdx = null;
    filterName = null;
    _isLoadEnd = false;
    userType = 0;
    getPartnerList();
    getProjectList();
    await getUserInfo();
    await getPartnerField();
    await getPartnerSkill();
    await getArea1();
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
      final response =
          await apiService.getPartnerList(page, filterIdx, filterName);
      if (response.statusCode == 200) {
        print(page);
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
          page++;
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
      final response = await apiService.getProjectList(page);
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
          page++;
          notifyListeners();
        }
      }
    } on DioException catch (e) {
      _isLoadEnd = true;
      print(e.response!.data);
    }
  }

  Future<void> getPartnerField() async {
    partnerFieldList = [];
    try {
      final response = await apiService.getPartnerField();
      partnerFieldList = (response.data as List)
          .map((item) => FieldModel.fromJson(item))
          .toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> getPartnerSkill() async {
    partnerSkillList = [];
    try {
      final response = await apiService.getPartnerSkill();
      partnerSkillList = (response.data as List)
          .map((item) => FieldModel.fromJson(item))
          .toList();
      notifyListeners();
      print(response.data);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> getArea1() async {
    area1List = [];
    try {
      final response = await apiService.getArea1();
      area1List = (response.data as List)
          .map((item) => AreaModel.fromJson(item))
          .toList();
      //idx 순으로 리스트정렬
      area1List.sort((a, b) => a.idx.compareTo(b.idx));
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> getArea2(int area1Idx) async {
    area2List = [];
    try {
      final response = await apiService.getArea2(area1Idx);
      area2List = (response.data as List)
          .map((item) => AreaModel.fromJson(item))
          .toList();
      notifyListeners();
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }

  void toggleLocalBtn(int index) {
    //다른값들은 모두 false로 변경
    for (int i = 0; i < area1List.length; i++) {
      if (i != index) {
        area1List[i].isChecked = false;
      } else {
        area1List[i].isChecked = true;
        getArea2(area1List[i].idx);
      }
    }
    notifyListeners();
  }

  void toggleCheckbox(int idx, String category) {
    switch (category) {
      case 'field':
        filterIdx = idx;
        filterName = "field";
        _toggleField(idx);
        break;
      case 'skill':
        filterIdx = idx;
        filterName = "skill";
        _toggleSkill(idx);
        break;
      case 'area':
        filterIdx = idx;
        filterName = "area";
        _toggleArea(idx);
        break;
      default:
        break;
    }
    notifyListeners();
  }

  void _toggleField(int idx) {
    for (var field in partnerFieldList) {
      field.isChecked = field.idx == idx ? !field.isChecked : false;
    }
    _resetOtherCategories('field');
  }

  void _toggleSkill(int idx) {
    for (var skill in partnerSkillList) {
      skill.isChecked = skill.idx == idx ? !skill.isChecked : false;
    }
    _resetOtherCategories('skill');
  }

  void _toggleArea(int idx) {
    for (var area in area2List) {
      area.isChecked = area.idx == idx ? !area.isChecked : false;
    }
    _resetOtherCategories('area');
  }

  void _resetOtherCategories(String currentCategory) {
    if (currentCategory != 'field') {
      for (var field in partnerFieldList) {
        field.isChecked = false;
      }
    }
    if (currentCategory != 'skill') {
      for (var skill in partnerSkillList) {
        skill.isChecked = false;
      }
    }
    if (currentCategory != 'area') {
      for (var area in area2List) {
        area.isChecked = false;
      }
    }
  }
}
