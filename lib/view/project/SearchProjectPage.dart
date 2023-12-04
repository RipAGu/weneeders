import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/project/SearchProjectViewModel.dart';
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
    // final viewModel = Provider.of<SearchProjectViewModel>(context);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: const SearchAppBar(
          title: "프로젝트 검색",
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<SearchProjectViewModel>(context, listen: false)
                .updateData();
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
          backgroundColor: Color(0xFF52C0FF),
          elevation: 0,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Consumer<SearchProjectViewModel>(
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
                            print(viewModel.project[index].title);
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
