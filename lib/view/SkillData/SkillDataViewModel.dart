import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:winit/network/ApiService.dart';
import 'package:winit/network/model/SkillDataDetailModel.dart';
import 'package:winit/network/model/SkillDataListModel.dart';

class SkillDataViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();
  List<SkillDataListModel> skillDataList = [];
  late SkillDataDetailModel skillDataDetail;
  int _page = 1;

  Future<void> init() async {}

  Future<void> getSkillDataList() async {
    try {
      final response = await apiService.getSkillDataList(_page);
      print(response.data);
      print(_page);
      if ((response.data as List).isEmpty) {
        print('데이터 없음');
      } else {
        print('데이터 있음');
        for (var item in response.data) {
          DateTime date = DateTime.parse(item['createdAt']);
          String formattedDate =
              "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";
          item['createdAt'] = formattedDate;
          item['thumbnailImgPath'] =
              "http://13.125.70.49${item['thumbnailImgPath']}";
          skillDataList.add(SkillDataListModel.fromJson(item));
        }
        _page++;
        notifyListeners();
      }
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }

  Future<void> getSkillDataDetail(int idx) async {
    try {
      final response = await apiService.getSkillDataDetail(idx);
      skillDataDetail = SkillDataDetailModel.fromJson(response.data);
      //createdat에 +9시간 해줘야함
      DateTime date = DateTime.parse(skillDataDetail.createdAt);
      date = date.add(const Duration(hours: 9));
      String formattedDate =
          "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";
      skillDataDetail.createdAt = formattedDate;
      skillDataDetail.thumbnailImgPath =
          "http://13.125.70.49${skillDataDetail.thumbnailImgPath}";
      skillDataDetail.videoPath =
          "http://13.125.70.49${skillDataDetail.videoPath}";
      notifyListeners();
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }
}
