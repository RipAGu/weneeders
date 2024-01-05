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
  late SocketService socketService;
  late int? roomIdx;
  late int? userIdx;
  late Future<void> _loadDataFuture;
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    socketService = SocketService();
    socketService.init(Provider.of<ChatViewModel>(context, listen: false));
    socketService.createSocketConnection(context);
    roomIdx = widget.roomIdx;
    userIdx = widget.userIdx;
    _loadDataFuture = loadData();
    _scrollController.addListener(_scrollListener);
    Provider.of<ChatViewModel>(context, listen: false).onMessageAdded =
        _scrollToBottom;
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      print(Provider.of<ChatViewModel>(context, listen: false).isLastMessage);
      if (_scrollController.position.pixels == 0 &&
          roomIdx != null &&
          !Provider.of<ChatViewModel>(context, listen: false).isLastMessage) {
        Provider.of<ChatViewModel>(context, listen: false)
            .getChatMessage(roomIdx!);
        print("top");
      }
    }
  }

  Future<void> loadData() async {
    await Provider.of<ChatViewModel>(context, listen: false).init();
    if (roomIdx != null) {
      await Provider.of<ChatViewModel>(context, listen: false)
          .getChatMessage(roomIdx!);
    }
    await Provider.of<ChatViewModel>(context, listen: false)
        .setUserIdx(userIdx!);
    _scrollToBottom();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    socketService.closeSocketConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });
          return Consumer<ChatViewModel>(
              builder: (context, viewModel, child) => Scaffold(
                    backgroundColor: Colors.white,
                    appBar: const TitleOnlyAppBar(title: "채팅"),
                    body: SafeArea(
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 60),
                            child: ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemCount: viewModel.chatMessageList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (viewModel.chatMessageList[index].type ==
                                      "date") {
                                    return ChatBubbleDate(
                                      date: viewModel
                                          .chatMessageList[index].message,
                                    );
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
