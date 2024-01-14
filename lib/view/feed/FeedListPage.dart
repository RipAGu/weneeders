import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/feed/AddFeedPage.dart';
import 'package:winit/view/feed/FeedDetailPage.dart';
import 'package:winit/view/feed/FeedViewModel.dart';
import 'package:winit/view/widget/CustomDrawer.dart';
import 'package:winit/view/widget/FeedCard.dart';
import 'package:winit/view/widget/MenuOnlyAppBar.dart';
import 'package:winit/view/widget/TitleOnlyAppBar.dart';

import '../account/SignInPage.dart';
import '../project/Register/RegisterPartnerPage.dart';
import '../project/Register/RegisterProjectPage.dart';
import '../project/Search/SearchViewModel.dart';
import '../widget/CustomDialogSelect.dart';
import '../widget/ProjectCard.dart';

class FeedListPage extends StatefulWidget {
  const FeedListPage({Key? key}) : super(key: key);

  @override
  State<FeedListPage> createState() => _FeedListPageState();
}

class _FeedListPageState extends State<FeedListPage> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _onScroll();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {
      _onScroll();
    });
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (!Provider.of<FeedViewModel>(context, listen: false).isLoadEnd) {
        Provider.of<FeedViewModel>(context, listen: false).getFeedList();
      }
    }
  }

  Future<void> loadData() async {
    await Provider.of<FeedViewModel>(context, listen: false).getFeedList();
  }

  @override
  Widget build(BuildContext context) {
    final mainContext = context;
    return FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<FeedViewModel>(
                builder: (context, viewModel, child) => MaterialApp(
                        home: Scaffold(
                      backgroundColor: Colors.white,
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
                      appBar: const MenuOnlyAppBar(
                        title: "피드",
                      ),
                      floatingActionButton: FloatingActionButton(
                        splashColor: Colors.transparent,
                        highlightElevation: 0,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddFeedPage())).then((value) {
                            if (value == true) {
                              Provider.of<FeedViewModel>(context, listen: false)
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
                      body: SafeArea(
                        child: SafeArea(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: ListView.builder(
                              controller: _scrollController,
                              itemCount: viewModel.feedList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                  child: FeedCard(
                                    image: viewModel.feedList[index].thumbnail,
                                    writer:
                                        viewModel.feedList[index].user.nickname,
                                    date: viewModel.feedList[index].createdAt,
                                    location: "",
                                    content: viewModel.feedList[index].contents,
                                    onPressed: () {
                                      Navigator.push(
                                        mainContext,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FeedDetailPage(
                                                    feedIdx: viewModel
                                                        .feedList[index].idx)),
                                      ).then((value) {
                                        if (value == true) {
                                          viewModel.init();
                                        }
                                      });
                                    },
                                    title: viewModel.feedList[index].title,
                                  ),
                                );
                              }),
                        )),
                      ),
                    )));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
