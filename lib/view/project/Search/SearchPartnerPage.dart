import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/account/SignInPage.dart';
import 'package:winit/view/project/Detail/DetailPartnerPage.dart';
import 'package:winit/view/project/Register/RegisterPartnerPage.dart';
import 'package:winit/view/project/Search/SearchViewModel.dart';
import 'package:winit/view/widget/CustomDrawer.dart';
import 'package:winit/view/widget/SearchAppBar.dart';

import '../../widget/CustomDialogPartnerFilter.dart';
import '../../widget/CustomDialogSelect.dart';
import '../../widget/ProjectCard.dart';

class SearchPartnerPage extends StatefulWidget {
  const SearchPartnerPage({Key? key}) : super(key: key);

  @override
  State<SearchPartnerPage> createState() => _SearchPartnerPageState();
}

class _SearchPartnerPageState extends State<SearchPartnerPage> {
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
      if (!Provider.of<SearchViewModel>(context, listen: false).isLoadEnd) {
        Provider.of<SearchViewModel>(context, listen: false).getPartnerList();
      }
    }
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
                            builder: (context) => const RegisterPartnerPage()));
                  },
                  registerPartner: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPartnerPage()));
                  },
                ),
                backgroundColor: Colors.white,
                appBar: SearchAppBar(
                    title: "파트너 검색",
                    onFilterTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              surfaceTintColor: Colors.white,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: CustomDialogPartnerFilter()),
                            );
                          });
                    }),
                floatingActionButton: Visibility(
                  visible: Provider.of<SearchViewModel>(context).userType == 2
                      ? true
                      : false,
                  child: FloatingActionButton(
                    splashColor: Colors.transparent,
                    highlightElevation: 0,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterPartnerPage())).then((value) {
                        if (value == true) {
                          Provider.of<SearchViewModel>(context, listen: false)
                              .init();
                        }
                      });
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
                            controller: _scrollController,
                            itemCount: viewModel.partnerList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 10),
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                child: ProjectCard(
                                  image: viewModel
                                          .partnerList[index].PartnerImg.isEmpty
                                      ? null
                                      : viewModel
                                          .partnerList[index].PartnerImg[0].img,
                                  writer:
                                      viewModel.partnerList[index].User.name,
                                  date: viewModel.partnerList[index].createdAt,
                                  location: viewModel.partnerList[index]
                                      .Depth2Region.Depth1Region.name,
                                  content: viewModel.partnerList[index].method,
                                  onPressed: () {
                                    Navigator.push(
                                      mainContext,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPartnerPage(
                                                  idx: viewModel
                                                      .partnerList[index].idx)),
                                    ).then((value) {
                                      if (value == true) {
                                        viewModel.init();
                                        viewModel.getPartnerList();
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
      },
    );
  }
}
