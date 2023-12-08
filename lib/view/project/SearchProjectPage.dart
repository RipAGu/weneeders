import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/project/DetailProjectPage.dart';
import 'package:winit/view/project/RegisterProjectPage.dart';
import 'package:winit/view/project/SearchViewModel.dart';
import 'package:winit/view/widget/SearchAppBar.dart';

import '../widget/ProjectCard.dart';

class SearchProjectPage extends StatefulWidget {
  const SearchProjectPage({Key? key}) : super(key: key);

  @override
  State<SearchProjectPage> createState() => _SearchProjectPageState();
}

class _SearchProjectPageState extends State<SearchProjectPage> {
  @override
  Widget build(BuildContext context) {
    final mainContext = context;
    // final viewModel = Provider.of<SearchProjectViewModel>(context);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: const SearchAppBar(
          title: "프로젝트 검색",
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.transparent,
          highlightElevation: 0,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterProjectPage()));
          },
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment(-0.59, 0.81),
                    end: Alignment(0.59, -0.81),
                    colors: [Color(0xFF3F9AFE), Color(0xFF52C0FF)])),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Consumer<SearchViewModel>(
              builder: (context, viewModel, child) {
                return ListView.builder(
                    itemCount: viewModel.project.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height * 0.13,
                        child: ProjectCard(
                          image: viewModel.project[index].image,
                          title: viewModel.project[index].title,
                          writer: viewModel.project[index].writer,
                          date: viewModel.project[index].date,
                          location: viewModel.project[index].location,
                          content: viewModel.project[index].content,
                          onPressed: () {
                            Navigator.push(
                                mainContext,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DetailProjectPage()));
                          },
                        ),
                      );
                    });
              },
            ),
          )),
        ),
      ),
    );
  }
}
