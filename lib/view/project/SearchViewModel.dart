import 'package:flutter/cupertino.dart';
import 'package:winit/view/widget/ProjectCard.dart';

class SearchViewModel with ChangeNotifier {
  final List<ProjectData> _project = [
    ProjectData(
        image: "assets/images/img.png",
        title: "인테리어 전문가",
        writer: "홍길동",
        date: "2023.03.15 08:45",
        location: "서울",
        content: "방화문 필름 리폼(밀크화이트) 가격, 낮은 수납장 설치/ 센서 등은 매립으로 설치. 안녕하세요. 이..."),
    ProjectData(
        image: "assets/images/img.png",
        title: "인테리어 전문가",
        writer: "홍길동",
        date: "2023.03.15 08:45",
        location: "서울",
        content: "방화문 필름 리폼(밀크화이트) 가격, 낮은 수납장 설치/ 센서 등은 매립으로 설치. 안녕하세요. 이..."),
    ProjectData(
        image: "assets/images/img.png",
        title: "인테리어 전문가",
        writer: "홍길동",
        date: "2023.03.15 08:45",
        location: "서울",
        content: "방화문 필름 리폼(밀크화이트) 가격, 낮은 수납장 설치/ 센서 등은 매립으로 설치. 안녕하세요. 이..."),
    ProjectData(
        image: "assets/images/img.png",
        title: "인테리어 전문가",
        writer: "홍길동",
        date: "2023.03.15 08:45",
        location: "서울",
        content: "방화문 필름 리폼(밀크화이트) 가격, 낮은 수납장 설치/ 센서 등은 매립으로 설치. 안녕하세요. 이..."),
    ProjectData(
        image: "assets/images/img.png",
        title: "인테리어 전문가",
        writer: "홍길동",
        date: "2023.03.15 08:45",
        location: "서울",
        content: "방화문 필름 리폼(밀크화이트) 가격, 낮은 수납장 설치/ 센서 등은 매립으로 설치. 안녕하세요. 이..."),
    ProjectData(
        image: "assets/images/img.png",
        title: "인테리어 전문가",
        writer: "홍길동",
        date: "2023.03.15 08:45",
        location: "서울",
        content: "방화문 필름 리폼(밀크화이트) 가격, 낮은 수납장 설치/ 센서 등은 매립으로 설치. 안녕하세요. 이..."),
    ProjectData(
        image: "assets/images/img.png",
        title: "인테리어 전문가",
        writer: "홍길동",
        date: "2023.03.15 08:45",
        location: "서울",
        content: "방화문 필름 리폼(밀크화이트) 가격, 낮은 수납장 설치/ 센서 등은 매립으로 설치. 안녕하세요. 이...")
  ];

  List<ProjectData> get project => _project;

  void addProject(ProjectData projectData) {
    _project.add(projectData);
    notifyListeners();
  }

  void updateData() {
    _project[0].title = "update";
    print(_project[0].title);
    notifyListeners();
  }
}
