import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/project/Detail/DetailProjectPage.dart';
import 'package:winit/view/project/Register/RegisterPartnerPage.dart';
import 'package:winit/view/project/Register/RegisterProjectPage.dart';
import 'package:winit/view/project/Search/SearchViewModel.dart';
import 'package:winit/view/widget/CustomDrawer.dart';
import 'package:winit/view/widget/SearchAppBar.dart';

import '../../account/SignInPage.dart';
import '../../widget/CustomDialogSelect.dart';
import '../../widget/ProjectCard.dart';

class SearchProjectPage extends StatefulWidget {
  const SearchProjectPage({Key? key}) : super(key: key);

  @override
  State<SearchProjectPage> createState() => _SearchProjectPageState();
}

class _SearchProjectPageState extends State<SearchProjectPage> {
  final ScrollController _scrollController = ScrollController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _onScroll();
    });
  }

  Future<void> loadData() async {
    await Provider.of<SearchViewModel>(context, listen: false).init();
  }

  void _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (!Provider.of<SearchViewModel>(context, listen: false).isLoadEnd) {
        Provider.of<SearchViewModel>(context, listen: false).getProjectList();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {
      _onScroll();
    });
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainContext = context;
    // final viewModel = Provider.of<SearchProjectViewModel>(context);
    return FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<SearchViewModel>(
              builder: (context, viewModel, child) => MaterialApp(
                home: Scaffold(
                  endDrawer: CustomDrawer(
                    onLogout: () {
                      showDialog(
                          context: context,
                          builder: (context) => CustomDialogSelect(
                              title: "로그아웃",
                              content: "로그아웃 하시겠습니까?",
                              cancelText: "취소",
                              confirmText: "확인",
                              cancelPressed: () {
                                Navigator.pop(context);
                              },
                              confirmPressed: () async {
                                print("로그아웃");
                                await storage.delete(key: "token");
                                if (!mounted) return;
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const SignInPage()),
                                    (route) => false);
                              }));
                    },
                    registerProject: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterProjectPage()));
                    },
                    registerPartner: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterPartnerPage()));
                    },
                  ),
                  backgroundColor: Colors.white,
                  appBar: const SearchAppBar(
                    title: "프로젝트 검색",
                  ),
                  floatingActionButton: Visibility(
                    visible: viewModel.userType == 1,
                    child: FloatingActionButton(
                      splashColor: Colors.transparent,
                      highlightElevation: 0,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegisterProjectPage())).then((value) {
                          if (value == true) {
                            Provider.of<SearchViewModel>(context, listen: false)
                                .init();
                          }
                        });
                      },
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
                                colors: [
                                  Color(0xFF3F9AFE),
                                  Color(0xFF52C0FF)
                                ])),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  body: SizedBox(
                    child: SafeArea(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Consumer<SearchViewModel>(
                        builder: (context, viewModel, child) {
                          return ListView.builder(
                              itemCount: viewModel.projectList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                  child: ProjectCard(
                                    image: viewModel.projectList[index]
                                            .ProjectImg.isEmpty
                                        ? null
                                        : viewModel.projectList[index]
                                            .ProjectImg[0].imgPath,
                                    writer: viewModel
                                        .projectList[index].User.nickname,
                                    date:
                                        viewModel.projectList[index].createdAt,
                                    location: viewModel.projectList[index]
                                        .Depth2Region.Depth1Region.name,
                                    content:
                                        viewModel.projectList[index].method,
                                    onPressed: () {
                                      Navigator.push(
                                          mainContext,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailProjectPage(
                                                    idx: viewModel
                                                        .projectList[index].idx,
                                                  ))).then((value) {
                                        if (value == true) {
                                          viewModel.init();
                                        }
                                      });
                                    },
                                  ),
                                );
                              });
                        },
                      ),
                    )),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
