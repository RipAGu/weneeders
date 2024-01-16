import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:winit/keys.dart';

class PaymentViewModel extends ChangeNotifier {
  late String secretKey;
  late Dio dio;
  bool _isPaymentSuccess = false;
  bool get isPaymentSuccess => _isPaymentSuccess;

  PaymentViewModel() {
    secretKey = Keys.paymentSecretKey;
    String authHeader = 'Basic ${base64Encode(utf8.encode('$secretKey:'))}';
    dio = Dio(
      BaseOptions(
        headers: {
          'Authorization': authHeader,
        },
      ),
    );
  }

  Future<Response> requestPaymentApi(
      int amount, String orderId, String paymentKey) async {
    try {
      Response response = await dio.post(
        'https://api.tosspayments.com/v1/payments/confirm',
        data: {
          "amount": amount,
          "orderId": orderId,
          "paymentKey": paymentKey,
        },
      );
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<void> requestPayment(
      int amount, String orderId, String paymentKey) async {
    try {
      final response = await requestPaymentApi(amount, orderId, paymentKey);
      log(response.data.toString());
      if (response.data['status'] == 'DONE') {
        _isPaymentSuccess = true;
      } else {
        _isPaymentSuccess = false;
      }
      notifyListeners();
    } on DioException catch (e) {
      print(e.response?.data);
      _isPaymentSuccess = false;
      rethrow;
    }
  }
}
