import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:winit/network/ApiService.dart';

class FindViewModel extends ChangeNotifier {
  bool _isPhoneSend = false;
  bool get isPhoneSend => _isPhoneSend;
  bool _isPhoneChecked = false;
  bool get isPhoneChecked => _isPhoneChecked;
  String _phoneToken = '';
  String get phoneToken => _phoneToken;
  String _email = '';
  String get email => _email;
  ApiService apiService = ApiService();
  bool _isChangePassword = false;
  bool get isChangePassword => _isChangePassword;

  Future<void> sendPhone(String phoneNumber, int type) async {
    try {
      final response = await apiService.phoneVerify(phoneNumber, type);
      print("response.data : ${response.data}");
      _isPhoneSend = true;
    } on DioException catch (e) {
      print(e.response!.data);
      _isPhoneSend = false;
    }
    notifyListeners();
  }

  Future<void> phoneVerifyCheck(
      String phoneNumber, String code, int type) async {
    try {
      final response =
          await apiService.phoneVerifyCheck(phoneNumber, code, type);
      print("response.data : ${response.data}");
      _phoneToken = response.data['token'];
      _isPhoneChecked = true;
      if (type == 2) findEmail();
    } on DioException catch (e) {
      print(e.response!.data);
      _isPhoneChecked = false;
    }
    notifyListeners();
  }

  Future<void> findEmail() async {
    try {
      final response = await apiService.findEmail(phoneToken);
      print("response.data : ${response.data}");
      _email = response.data['email'];
    } on DioException catch (e) {
      print("e.response!.data : ${e.response!.data} ${e.response!.statusCode}");
    }
  }

  Future<void> changePassword(String email, String pw) async {
    try {
      final response = await apiService.changePassword(email, phoneToken, pw);
      _isChangePassword = true;
      print("response.data : ${response.data}");
    } on DioException catch (e) {
      _isChangePassword = false;
      print("e.response!.data : ${e.response!.data} ${e.response!.statusCode}");
    }
  }
}
