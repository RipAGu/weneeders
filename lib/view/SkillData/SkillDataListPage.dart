import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/SkillData/SkillDataDetailPage.dart';
import 'package:winit/view/SkillData/SkillDataViewModel.dart';
import 'package:winit/view/widget/DataSkillCard.dart';
import 'package:winit/view/widget/TitleOnlyAppBar.dart';
import '../project/Search/SearchViewModel.dart';

class SkillDataListPage extends StatefulWidget {
  const SkillDataListPage({Key? key}) : super(key: key);

  @override
  State<SkillDataListPage> createState() => _SkillDataListPageState();
}

class _SkillDataListPageState extends State<SkillDataListPage> {
  final ScrollController _scrollController = ScrollController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late Future<void> _loadDataFuture;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _onScroll();
    });
    _loadDataFuture = loadData();
  }

  Future<void> loadData() async {
    await Provider.of<SkillDataViewModel>(context, listen: false).init();
    await Provider.of<SkillDataViewModel>(context, listen: false)
        .getSkillDataList();
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
    return FutureBuilder(
      future: _loadDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<SkillDataViewModel>(
            builder: (context, viewModel, child) => MaterialApp(
              home: Scaffold(
                backgroundColor: Colors.white,
                appBar: const TitleOnlyAppBar(
                  title: "기술 자료",
                ),
                body: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Consumer<SkillDataViewModel>(
                      builder: (context, viewModel, child) {
                        return ListView.builder(
                            controller: _scrollController,
                            itemCount: viewModel.skillDataList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 10),
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                child: DataSkillCard(
                                  image: viewModel.skillDataList[index]
                                          .thumbnailImgPath.isEmpty
                                      ? null
                                      : viewModel.skillDataList[index]
                                          .thumbnailImgPath,
                                  writer: viewModel
                                      .skillDataList[index].User.nickname,
                                  date:
                                      viewModel.skillDataList[index].createdAt,
                                  content: viewModel.skillDataList[index].title,
                                  onPressed: () {
                                    Navigator.push(
                                        mainContext,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SkillDataDetailPage(
                                                  idx: viewModel
                                                      .skillDataList[index].idx,
                                                )));
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
