import 'package:flutter/cupertino.dart';

class MainViewModel extends ChangeNotifier {
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
