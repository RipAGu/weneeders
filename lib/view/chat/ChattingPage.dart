import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/network/SocketService.dart';
import 'package:winit/view/chat/ChatViewModel.dart';
import 'package:winit/view/widget/ChatBubbleDate.dart';
import 'package:winit/view/widget/ChatBubbleRecieve.dart';
import 'package:winit/view/widget/ChatBubbleSend.dart';
import 'package:winit/view/widget/SearchAppBar.dart';
import 'package:winit/view/widget/TitleOnlyAppBar.dart';

class ChattingPage extends StatefulWidget {
  final int? roomIdx;
  final int userIdx;
  const ChattingPage({Key? key, this.roomIdx, required this.userIdx})
      : super(key: key);
  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  late int? roomIdx;
  late int? userIdx;
  late Future<void> _loadDataFuture;
  final TextEditingController _chatController = TextEditingController();
  @override
  void initState() {
    super.initState();
    roomIdx = widget.roomIdx;
    userIdx = widget.userIdx;
    _loadDataFuture = loadData();
  }

  Future<void> loadData() async {
    await Provider.of<ChatViewModel>(context, listen: false).init();
    if (roomIdx != null) {
      await Provider.of<ChatViewModel>(context, listen: false)
          .getChatMessage(roomIdx!);
    }
    await Provider.of<ChatViewModel>(context, listen: false)
        .setUserIdx(userIdx!);
  }

  @override
  Widget build(BuildContext context) {
    final socketService = SocketService();
    socketService.createSocketConnection(context);
    return FutureBuilder(
      future: _loadDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<ChatViewModel>(
              builder: (context, viewModel, child) => Scaffold(
                    backgroundColor: Colors.white,
                    appBar: const TitleOnlyAppBar(title: "채팅"),
                    body: SafeArea(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: viewModel.chatMessageList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (viewModel.chatMessageList[index].type ==
                                      "date") {
                                    return ChatBubbleDate();
                                  } else if (viewModel
                                          .chatMessageList[index].type ==
                                      "send") {
                                    return ChatBubbleSend(
                                      message: viewModel.chatMessageList[index],
                                    );
                                  } else {
                                    return ChatBubbleReceive(
                                      message: viewModel.chatMessageList[index],
                                    );
                                  }
                                }),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 16,
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0xFFF2F6F8),
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xffE5E5E5),
                                    width: 1,
                                  ),
                                ),
                              ),
                              height: 50,
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 40),
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    height: double.infinity,
                                    child: CupertinoTextField(
                                      controller: _chatController,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      color: const Color(0xffA9B0B8),
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        if (_chatController.text.isNotEmpty) {
                                          viewModel.sendChatMessage(
                                              viewModel.userIdx,
                                              _chatController.text);
                                          _chatController.clear();
                                        }
                                      },
                                      icon: SvgPicture.asset(
                                        "assets/icons/send.svg",
                                        colorFilter: const ColorFilter.mode(
                                            Color(0xff2D8DF4), BlendMode.srcIn),
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
