import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:winit/network/ApiService.dart';

import '../../widget/CustomCheckboxTile.dart';

class AddViewModel extends ChangeNotifier {
  List<Item> testList = [
    Item(title: "전문분야1", isChecked: false),
    Item(title: "전문분야2", isChecked: true),
    Item(title: "전문분야3", isChecked: false),
    Item(title: "전문분야4", isChecked: false),
    Item(title: "전문분야5", isChecked: false),
    Item(title: "전문분야6", isChecked: false),
    Item(title: "전문분야7", isChecked: false),
    Item(title: "전문분야8", isChecked: false),
    Item(title: "전문분야9", isChecked: false),
    Item(title: "전문분야10", isChecked: false),
  ];

  List<Item> testList2 = [
    Item(title: "엑셀", isChecked: false),
    Item(title: "파워포인트", isChecked: true),
    Item(title: "포토샵", isChecked: false),
    Item(title: "일러스트", isChecked: false),
    Item(title: "프리미어", isChecked: false),
    Item(title: "애프터이펙트", isChecked: false),
  ];

  List<LocalData> localList = [
    LocalData(title: "서울", isChecked: false),
    LocalData(title: "경기", isChecked: false),
    LocalData(title: "인천", isChecked: false),
    LocalData(title: "강원", isChecked: false),
  ];

  List<RegionData> regionList = [
    RegionData(title: "강남/역삼/삼성/논현", isChecked: false),
    RegionData(title: "서초/신사/방배", isChecked: false),
    RegionData(title: "잠실/신천/송파/강동", isChecked: false),
    RegionData(title: "건대/군자/구의/성수", isChecked: false),
    RegionData(title: "왕십리/행당/성동/금호", isChecked: false),
    RegionData(title: "동대문/신설/용두/이문", isChecked: false),
    RegionData(title: "종로/대학로/동묘앞/신설동", isChecked: false),
  ];

  List<Item> methodList = [
    Item(title: "기간제", isChecked: false),
    Item(title: "도급제", isChecked: false),
  ];

  List<ImageData> testImg = [
    ImageData(image: null),
  ];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final ApiService apiService = ApiService();

  void toggleFieldCheckbox(int index) {
    testList[index].isChecked = !testList[index].isChecked;
    print(testList[index].isChecked);
    notifyListeners();
  }

  void toggleTechCheckbox(int index) {
    testList2[index].isChecked = !testList2[index].isChecked;
    print(testList2[index].isChecked);
    notifyListeners();
  }

  void toggleLocalBtn(int index) {
    //다른값들은 모두 false로 변경
    for (int i = 0; i < localList.length; i++) {
      if (i != index) {
        localList[i].isChecked = false;
      } else {
        localList[i].isChecked = true;
      }
    }
    notifyListeners();
  }

  void toggleRegionBtn(int index) {
    //다른값들은 모두 false로 변경
    for (int i = 0; i < regionList.length; i++) {
      if (i != index) {
        regionList[i].isChecked = false;
      } else {
        regionList[i].isChecked = true;
      }
    }
    notifyListeners();
  }

  void toggleMethodBtn(int index) {
    //다른값들은 모두 false로 변경
    for (int i = 0; i < methodList.length; i++) {
      if (i != index) {
        methodList[i].isChecked = false;
      } else {
        methodList[i].isChecked = true;
      }
    }
    notifyListeners();
  }

  void addImg() {
    _pickImg();
  }

  Future<void> _pickImg() async {
    //이미지 선택 함수
    _isLoading = true;
    notifyListeners();
    final pickedFile = ImagePicker();
    final List<XFile> images = await pickedFile.pickMultiImage();
    for (int i = 0; i < images.length; i++) {
      testImg.add(ImageData(image: images[i].path));
    }
    notifyListeners();
    //1초 기다림
    await Future.delayed(const Duration(seconds: 1));
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getProjectField() async {
    try {
      final response = await apiService.getProjectField();
      print(response.data);
      print(response.statusCode);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> getArea1() async {
    try {
      final response = await apiService.getArea1();
      print(response.data);
      print(response.statusCode);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}

class LocalData {
  final String title;
  bool isChecked;

  LocalData({required this.title, required this.isChecked});
}

class RegionData {
  final String title;
  bool isChecked;

  RegionData({required this.title, required this.isChecked});
}

class ImageData {
  final String? image;

  ImageData({required this.image});
}
