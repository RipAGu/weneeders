import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:winit/network/ApiService.dart';

import '../../network/model/PartnerListModel.dart';

class RecommendViewModel extends ChangeNotifier {
  List<PartnerListModel> partnerList = [];
  final ApiService apiService = ApiService();

  Future<void> init() async {
    partnerList = [];
  }

  Future<void> getRecommendList(int region) async {
    try {
      final response = await apiService.getRecommendList(region);
      print(response.data);
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

      notifyListeners();
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }
}
