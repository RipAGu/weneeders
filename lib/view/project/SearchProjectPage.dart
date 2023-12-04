import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/widget/MainAppBar.dart';
import 'package:winit/view/widget/SearchAppBar.dart';

import '../widget/ProjectCard.dart';

class SearchProjectPage extends StatefulWidget {
  const SearchProjectPage({Key? key}) : super(key: key);

  @override
  State<SearchProjectPage> createState() => _SearchProjectPageState();
}

class _SearchProjectPageState extends State<SearchProjectPage> {
  List<ProjectData> projects = [
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
    ProjectData(
        image: "assets/images/img.png",
        title: "test",
        writer: "test",
        date: "date",
        location: "location",
        content: "content"),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => null,
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: const SearchAppBar(
            title: "프로젝트 검색",
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999)),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Color(0xFF52C0FF),
            elevation: 0,
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.13,
                      child: ProjectCard(
                        image: projects[index].image,
                        title: projects[index].title,
                        writer: projects[index].writer,
                        date: projects[index].date,
                        location: projects[index].location,
                        content: projects[index].content,
                        onPressed: () {},
                      ),
                    );
                  }),
            )),
          ),
        ),
      ),
    );
  }
}
