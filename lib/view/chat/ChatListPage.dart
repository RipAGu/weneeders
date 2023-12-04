import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/chat/ChatViewModel.dart';
import 'package:winit/view/widget/ChatCard.dart';
import 'package:winit/view/widget/SearchAppBar.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => null,
        child: MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.white,
            appBar: const SearchAppBar(title: "채팅"),
            body: SizedBox(
              width: double.infinity,
              child: SafeArea(
                child: Consumer<ChatViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.chatList.isEmpty) {
                      return Center(
                        child:
                            SvgPicture.asset("assets/images/no_chat_image.svg"),
                      );
                    } else {
                      return Consumer<ChatViewModel>(
                        builder: (context, viewModel, child) {
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: ListView.builder(
                              itemCount: viewModel.chatList.length + 1,
                              itemBuilder: (context, index) {
                                if (index == viewModel.chatList.length) {
                                  return const SizedBox(height: 20);
                                }
                                return Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                  child: ChatCard(
                                    isNew: viewModel.chatList[index].isNew,
                                    name: viewModel.chatList[index].name,
                                    content: viewModel.chatList[index].content,
                                    date: viewModel.chatList[index].date,
                                    onPressed: () {},
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
        ));
  }
}
