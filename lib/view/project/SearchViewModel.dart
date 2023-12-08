import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/widget/ProjectCard.dart';

class SearchViewModel with ChangeNotifier {
  final List<ProjectData> _project = [
    ProjectData(
        image: "assets/images/img.png",
        title: "qtzsdfssdz",
        writer: "test",
        date: "date",
        location: "location",
        content: "content"),
    ProjectData(
        image: "assets/images/img.png",
        title: "test",
        writer: "test",
        date: "date",
        location: "location",
        content: "content"),
    ProjectData(
        image: "assets/images/img.png",
        title: "test",
        writer: "test",
        date: "date",
        location: "location",
        content: "content"),
    ProjectData(
        image: "assets/images/img.png",
        title: "test",
        writer: "test",
        date: "date",
        location: "location",
        content: "content"),
    ProjectData(
        image: "assets/images/img.png",
        title: "test",
        writer: "test",
        date: "date",
        location: "location",
        content: "content"),
    ProjectData(
        image: "assets/images/img.png",
        title: "test",
        writer: "test",
        date: "date",
        location: "location",
        content: "content"),
    ProjectData(
        image: "assets/images/img.png",
        title: "test",
        writer: "test",
        date: "date",
        location: "location",
        content: "content"),
    ProjectData(
        image: "assets/images/img.png",
        title: "test",
        writer: "test",
        date: "date",
        location: "location",
        content: "content"),
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
