import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/chat/ChatViewModel.dart';
import 'package:winit/view/widget/ChatBubbleDate.dart';
import 'package:winit/view/widget/ChatBubbleRecieve.dart';
import 'package:winit/view/widget/ChatBubbleSend.dart';
import 'package:winit/view/widget/SearchAppBar.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({Key? key}) : super(key: key);
  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatViewModel(),
      child: Consumer<ChatViewModel>(
          builder: (context, viewModel, child) => SafeArea(
                  child: Scaffold(
                backgroundColor: Colors.white,
                appBar: SearchAppBar(title: "채팅"),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: ChatBubbleDate(),
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
                        width: double.infinity,
                        height: 50,
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 40),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: double.infinity,
                              child: const CupertinoTextField(
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                color: const Color(0xffA9B0B8),
                                padding: EdgeInsets.zero,
                                onPressed: () {},
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
              ))),
    );
  }
}
