import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/widget/CustomTextFieldGray.dart';

class AddFeedPage extends StatefulWidget {
  const AddFeedPage({Key? key}) : super(key: key);

  @override
  State<AddFeedPage> createState() => _AddFeedPageState();
}

class _AddFeedPageState extends State<AddFeedPage> {
  final TextEditingController _feedTitle = TextEditingController();
  final TextEditingController _feedContent = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => null,
        child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SafeArea(
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: null,
                            icon: SvgPicture.asset(
                                "assets/icons/icon_profile.svg")),
                        SvgPicture.asset(
                          "assets/icons/logo.svg",
                          width: MediaQuery.of(context).size.width * 0.2,
                          semanticsLabel: "logo",
                        ),
                        IconButton(
                            onPressed: null,
                            icon: SvgPicture.asset("assets/icons/menu.svg"))
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: CustomTextFieldGray(
                        controller: _feedTitle,
                        hintText: "피드 내용을 입력해주세요",
                        keyboardType: TextInputType.multiline,
                        obscureText: false,
                        textFontSize: 12,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.37,
                      child: CustomTextFieldGray(
                        controller: _feedContent,
                        hintText: "게시글을 작성해주세요",
                        keyboardType: TextInputType.multiline,
                        obscureText: false,
                        textFontSize: 12,
                      ),
                    )
                  ],
                ),
              )),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.all(0),
            color: const Color(0x00000000),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                    color: Color(0xFFA8B0B8),
                    width: 0.5,
                  ))),
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
              height: 60,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/trash.svg",
                            height: 50,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/backarrow.svg",
                            height: 50,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
