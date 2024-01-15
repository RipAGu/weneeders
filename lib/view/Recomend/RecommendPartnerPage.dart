import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/Recomend/RecommendViewModel.dart';
import 'package:winit/view/widget/CustomDrawer.dart';
import 'package:winit/view/widget/MenuOnlyAppBar.dart';
import 'package:winit/view/widget/TitleOnlyAppBar.dart';

import '../account/SignInPage.dart';
import '../project/Register/RegisterPartnerPage.dart';
import '../widget/CustomDialogSelect.dart';
import '../widget/ProjectCard.dart';

class RecommendPartnerPage extends StatefulWidget {
  int region;
  RecommendPartnerPage({Key? key, required this.region}) : super(key: key);

  @override
  State<RecommendPartnerPage> createState() => _RecommendPartnerPageState();
}

class _RecommendPartnerPageState extends State<RecommendPartnerPage> {
  late int region;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    Provider.of<RecommendViewModel>(context, listen: false).init();
    region = widget.region;
  }

  Future<void> loadData() async {
    await Provider.of<RecommendViewModel>(context, listen: false)
        .getRecommendList(66);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          return Consumer(
              builder: (context, viewModel, child) => MaterialApp(
                    home: Scaffold(
                      backgroundColor: Colors.white,
                      body: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Consumer<RecommendViewModel>(
                            builder: (context, viewModel, child) {
                              return ListView.builder(
                                  itemCount: viewModel.partnerList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.13,
                                      child: ProjectCard(
                                        image: viewModel.partnerList[index]
                                                .PartnerImg.isEmpty
                                            ? null
                                            : viewModel.partnerList[index]
                                                .PartnerImg[0].img,
                                        writer: viewModel
                                            .partnerList[index].User.name,
                                        date: viewModel
                                            .partnerList[index].createdAt,
                                        location: viewModel.partnerList[index]
                                            .Depth2Region.Depth1Region.name,
                                        content:
                                            viewModel.partnerList[index].method,
                                        onPressed: () {
                                          // Navigator.push(
                                          //   mainContext,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           DetailPartnerPage(
                                          //               idx: viewModel
                                          //                   .partnerList[index]
                                          //                   .idx)),
                                          // ).then((value) {
                                          //   if (value == true) {
                                          //     viewModel.init();
                                          //     viewModel.getPartnerList();
                                          //   }
                                          // });
                                        },
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                      ),
                      appBar: const TitleOnlyAppBar(
                        title: "위닛이 추천하는 파트너들 입니다",
                      ),
                    ),
                  ));
        });
  }
}
