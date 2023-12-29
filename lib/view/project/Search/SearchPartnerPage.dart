import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/account/SignInPage.dart';
import 'package:winit/view/project/Detail/DetailProjectPage.dart';
import 'package:winit/view/project/Register/RegisterPartnerPage.dart';
import 'package:winit/view/project/Search/SearchViewModel.dart';
import 'package:winit/view/widget/CustomDrawer.dart';
import 'package:winit/view/widget/SearchAppBar.dart';

import '../../widget/ProjectCard.dart';

class SearchPartnerPage extends StatefulWidget {
  const SearchPartnerPage({Key? key}) : super(key: key);

  @override
  State<SearchPartnerPage> createState() => _SearchPartnerPageState();
}

class _SearchPartnerPageState extends State<SearchPartnerPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<SearchViewModel>(context, listen: false).init();
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
      if (!Provider.of<SearchViewModel>(context, listen: false).isLoadEnd) {
        Provider.of<SearchViewModel>(context, listen: false).getPartnerList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainContext = context;
    // final viewModel = Provider.of<SearchProjectViewModel>(context);
    return MaterialApp(
      home: Scaffold(
        endDrawer: CustomDrawer(
          onLogout: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SignInPage()));
          },
        ),
        backgroundColor: Colors.white,
        appBar: const SearchAppBar(
          title: "파트너 검색",
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.transparent,
          highlightElevation: 0,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterPartnerPage()));
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
                    controller: _scrollController,
                    itemCount: viewModel.partnerList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height * 0.13,
                        child: ProjectCard(
                          image: "assets/images/img.png",
                          writer: viewModel.partnerList[index].User.name,
                          date: viewModel.partnerList[index].createdAt,
                          location: viewModel.partnerList[index].Depth2Region
                              .Depth1Region.name,
                          content: viewModel.partnerList[index].method,
                          onPressed: () {
                            Navigator.push(
                              mainContext,
                              MaterialPageRoute(
                                  builder: (context) => const DetailProjectPage(
                                        idx: 4,
                                      )),
                            );
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
