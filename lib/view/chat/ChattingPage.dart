import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tosspayments_widget_sdk_flutter/model/paymentData.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_info.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_widget_options.dart';
import 'package:tosspayments_widget_sdk_flutter/payment_widget.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/agreement.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/payment_method.dart';
import 'package:winit/network/SocketService.dart';
import 'package:winit/view/chat/ChatViewModel.dart';
import 'package:winit/view/payment/PaymentTestPage.dart';
import 'package:winit/view/widget/ChatBubbleDate.dart';
import 'package:winit/view/widget/ChatBubbleRecieve.dart';
import 'package:winit/view/widget/ChatBubbleSend.dart';
import 'package:winit/view/widget/CustomDialogPayment.dart';
import 'package:winit/view/widget/TitleOnlyAppBar.dart';

import '../payment/PaymentPage.dart';

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
  final TextEditingController _paymentController = TextEditingController();
  late PaymentWidget _paymentWidget;
  PaymentMethodWidgetControl? _paymentMethodWidgetControl;
  AgreementWidgetControl? _agreementWidgetControl;
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

    // 페이먼트 테스트
    _paymentWidget = PaymentWidget(
        clientKey: "test_ck_Poxy1XQL8RwZBgJjGzlk37nO5Wml",
        customerKey: "-9-6SiquogiXqJ6unZsfA");
    _paymentWidget
        .renderPaymentMethods(
            selector: 'methods',
            amount: Amount(value: 300, currency: Currency.KRW, country: "KR"),
            options: RenderPaymentMethodsOptions(variantKey: "DEFAULT"))
        .then((control) {
      _paymentMethodWidgetControl = control;
    });
    _paymentWidget.renderAgreement(selector: 'agreement').then((control) {
      _agreementWidgetControl = control;
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0 &&
          roomIdx != null &&
          !Provider.of<ChatViewModel>(context, listen: false).isLastMessage) {
        Provider.of<ChatViewModel>(context, listen: false)
            .getChatMessage(roomIdx!);
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
  }

  @override
  void dispose() {
    _scrollController.dispose();
    socketService.closeSocketConnection();
    print("dispose");
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
                            margin: const EdgeInsets.only(bottom: 70),
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: Column(
                                children: List.generate(
                                  viewModel.chatMessageList.length,
                                  (index) {
                                    var message =
                                        viewModel.chatMessageList[index];
                                    if (message.type == "date") {
                                      return ChatBubbleDate(
                                          date: message.message);
                                    } else if (message.type == "send") {
                                      return ChatBubbleSend(message: message);
                                    } else {
                                      return ChatBubbleReceive(
                                          message: message);
                                    }
                                  },
                                ),
                              ),
                            ),
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
                                        MediaQuery.of(context).size.width * 0.6,
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
                                  SizedBox(
                                    width: 30,
                                    height: 40,
                                    child: IconButton(
                                        padding: EdgeInsets.zero,
                                        color: const Color(0xffA9B0B8),
                                        onPressed: () async {
                                          _paymentController.clear();
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  surfaceTintColor:
                                                      Colors.white,
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      child:
                                                          CustomDialogPayment(
                                                        controller:
                                                            _paymentController,
                                                      )),
                                                );
                                              }).then((value) async => {
                                                if (value != null &&
                                                    value.isNotEmpty)
                                                  {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PaymentTestPage(
                                                                amount:
                                                                    int.parse(
                                                                        value),
                                                              )),
                                                    )
                                                  }
                                              });
                                        },
                                        icon: SvgPicture.asset(
                                          "assets/icons/payment.svg",
                                          colorFilter: const ColorFilter.mode(
                                              Color(0xff2D8DF4),
                                              BlendMode.srcIn),
                                        )),
                                  ),
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
