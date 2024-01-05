import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:winit/view/widget/TitleOnlyAppBar.dart';

import 'SkillDataViewModel.dart';

class SkillDataDetailPage extends StatefulWidget {
  final int idx;

  const SkillDataDetailPage({Key? key, required this.idx}) : super(key: key);
  @override
  _SkillDataDetailPageState createState() => _SkillDataDetailPageState();
}

class _SkillDataDetailPageState extends State<SkillDataDetailPage> {
  late int idx;
  late Future<void> _loadDataFuture;
  late VideoPlayerController _controller;

  Future<void> loadData() async {
    await Provider.of<SkillDataViewModel>(context, listen: false).init();
    await Provider.of<SkillDataViewModel>(context, listen: false)
        .getSkillDataDetail(idx);
    print(Provider.of<SkillDataViewModel>(context, listen: false)
        .skillDataDetail
        .videoPath);
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        Provider.of<SkillDataViewModel>(context, listen: false)
            .skillDataDetail
            .videoPath))
      ..initialize().then((value) => setState(() {
            _controller.play();
          }));
  }

  @override
  void initState() {
    super.initState();
    idx = widget.idx;
    _loadDataFuture = loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<SkillDataViewModel>(
              builder: (context, viewModel, child) => Scaffold(
                  backgroundColor: Colors.white,
                  appBar: TitleOnlyAppBar(
                    title: viewModel.skillDataDetail.title,
                  ),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Column(
                          children: [
                            Container(
                              //작성자 정보
                              margin: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                          children: <TextSpan>[
                                        const TextSpan(text: "작성자: "),
                                        TextSpan(
                                            text: viewModel
                                                .skillDataDetail.User.nickname,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                      ])),
                                  const Spacer(),
                                  Text(
                                    viewModel.skillDataDetail.createdAt,
                                    style: const TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  _controller.play();
                                }
                              },
                              child: Container(
                                //비디오
                                margin: const EdgeInsets.only(top: 10),
                                height: 200,
                                child: _controller.value.isInitialized
                                    ? AspectRatio(
                                        aspectRatio:
                                            _controller.value.aspectRatio,
                                        child: VideoPlayer(_controller),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 5)),
                            const Padding(padding: EdgeInsets.only(bottom: 45)),
                          ],
                        ),
                      ),
                    ),
                  )),
            );
          } else {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
        });
  }
}
