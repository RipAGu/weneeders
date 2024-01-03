import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../network/ApiService.dart';

class SignInViewModel extends ChangeNotifier {
  bool _isLoginSuccess = false;
  bool get isLoginSuccess => _isLoginSuccess;

  late final String token;
  static const storage = FlutterSecureStorage();

  final ApiService apiService = ApiService();

  Future<void> login(String email, String password) async {
    try {
      final response = await apiService.login(email, password);
      _isLoginSuccess = true;
      token = response.data['token'];
      await storage.write(key: "token", value: token);
      notifyListeners();
    } on DioException catch (e) {
      _isLoginSuccess = false;
      notifyListeners();
    }
  }
}
