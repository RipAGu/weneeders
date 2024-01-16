import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/chat/ChatViewModel.dart';
import 'package:winit/view/chat/ChattingPage.dart';
import 'package:winit/view/widget/ChatCard.dart';
import 'package:winit/view/widget/MenuOnlyAppBar.dart';
import 'package:winit/view/widget/SearchAppBar.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late Future<void> _loadDataFuture;

  Future<void> loadData() async {
    await Provider.of<ChatViewModel>(context, listen: false)
        .getChattingRoomList();
  }

  @override
  void initState() {
    super.initState();
    _loadDataFuture = loadData();
  }

  @override
  Widget build(BuildContext context) {
    final mainContext = context;
    return FutureBuilder(
      future: _loadDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.white,
              appBar: const MenuOnlyAppBar(title: "채팅"),
              body: SizedBox(
                width: double.infinity,
                child: SafeArea(
                  child: Consumer<ChatViewModel>(
                    builder: (context, viewModel, child) {
                      if (viewModel.chattingRoomList.isEmpty) {
                        return Center(
                          child: SvgPicture.asset(
                              "assets/images/no_chat_image.svg"),
                        );
                      } else {
                        return Consumer<ChatViewModel>(
                          builder: (context, viewModel, child) {
                            return Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: ListView.builder(
                                itemCount: viewModel.chattingRoomList.length,
                                itemBuilder: (context, index) {
                                  if (index ==
                                      viewModel.chattingRoomList.length) {
                                    return const SizedBox(height: 20);
                                  }
                                  return Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    height: MediaQuery.of(context).size.height *
                                        0.13,
                                    child: ChatCard(
                                      isNew: viewModel.chattingRoomList[index]
                                              .messageCount >
                                          0,
                                      name: viewModel.chattingRoomList[index]
                                          .user.nickname,
                                      content: viewModel
                                          .chattingRoomList[index].curMessage,
                                      date: viewModel.chattingRoomList[index]
                                          .curMessageTime,
                                      onPressed: () async {
                                        await Navigator.push(
                                          mainContext,
                                          MaterialPageRoute(
                                            builder: (context) => ChattingPage(
                                              roomIdx: viewModel
                                                  .chattingRoomList[index].idx,
                                              userIdx: viewModel
                                                  .chattingRoomList[index]
                                                  .user
                                                  .idx,
                                            ),
                                          ),
                                        );
                                        await viewModel.getChattingRoomList();
                                        print("채팅방 리스트 갱신 완료");
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
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
