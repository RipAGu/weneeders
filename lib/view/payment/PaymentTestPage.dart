import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tosspayments_widget_sdk_flutter/model/paymentData.dart';
import 'package:tosspayments_widget_sdk_flutter/model/tosspayments_result.dart';
import 'package:tosspayments_widget_sdk_flutter/pages/tosspayments_sdk_flutter.dart';
import 'package:winit/view/payment/PaymentViewModel.dart';

import 'PaymentSuccessPage.dart';

class PaymentTestPage extends StatelessWidget {
  final int amount;
  PaymentTestPage({Key? key, required this.amount}) : super(key: key);

  String generateRandomOrderId() {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_';
    final Random random = Random();
    final int length = 6 + random.nextInt(12); // 6자 이상 64자 이하
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    PaymentData data = PaymentData(
      orderId: generateRandomOrderId(),
      orderName: "공사금액",
      amount: amount,
      paymentMethod: '카드',
    );

    return Consumer<PaymentViewModel>(
      builder: (context, viewModel, child) => TossPayments(
          clientKey: 'test_ck_Poxy1XQL8RwZBgJjGzlk37nO5Wml',
          data: data,
          success: (Success success) async {
            print("success");
            print(success.amount);
            print(success.orderId);
            print(success.paymentKey);
            await viewModel.requestPayment(
                success.amount as int, success.orderId, success.paymentKey);
            if (viewModel.isPaymentSuccess) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentSuccessPage(
                            amount: amount,
                            orderId: success.orderId as String,
                          )));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("결제 실패")));
              Navigator.pop(context);
            }
          },
          fail: (Fail fail) {
            print("fail ${fail.errorMessage}");
            print("fail");
            Navigator.pop(context);
          }),
    );
  }
}
