import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:winit/network/ApiService.dart';
import 'package:winit/network/model/TestModel.dart';

class RegisterViewModel extends ChangeNotifier {
  bool _isAllChecked = false;
  bool get isAllChecked => _isAllChecked;

  bool _isTotalCheck = false;
  bool get isTotalCheck => _isTotalCheck;

  bool _isServiceCheck = false;
  bool get isServiceCheck => _isServiceCheck;

  bool _isPrivacyCheck = false;
  bool get isPrivacyCheck => _isPrivacyCheck;

  bool _isMarketingCheck = false;
  bool get isMarketingCheck => _isMarketingCheck;

  bool _nickNameCheck = false;
  bool get nickNameCheck => _nickNameCheck;

  bool _isEmailCheck = false;
  bool get isEmailCheck => _isEmailCheck;

  bool _isSendPhone = false;
  bool get isSendPhone => _isSendPhone;

  bool _isPhoneCheck = false;
  bool get isPhoneCheck => _isPhoneCheck;

  bool _isRegisterSuccess = false;
  bool get isRegisterSuccess => _isRegisterSuccess;

  late final String phoneToken;

  final ApiService apiService = ApiService();
  static const storage = FlutterSecureStorage();

  late List<TestModel?> _testModel;

  void setTotalCheck(bool value) {
    _isTotalCheck = value;
    _isServiceCheck = value;
    _isPrivacyCheck = value;
    _isMarketingCheck = value;
    isAllCheckedValue();
    notifyListeners();
  }

  void setServiceCheck(bool value) {
    _isServiceCheck = value;
    isAllCheckedValue();
    notifyListeners();
  }

  void setPrivacyCheck(bool value) {
    _isPrivacyCheck = value;
    isAllCheckedValue();
    notifyListeners();
  }

  void setMarketingCheck(bool value) {
    _isMarketingCheck = value;
    isAllCheckedValue();
    notifyListeners();
  }

  void isAllCheckedValue() {
    if (_isServiceCheck && _isPrivacyCheck && _isMarketingCheck) {
      _isTotalCheck = true;
      _isAllChecked = true;
    } else {
      _isAllChecked = false;
      _isTotalCheck = false;
    }
    notifyListeners();
  }

  Future<void> getTest() async {
    try {
      _testModel = await apiService.getTest();
      print(_testModel);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> emailDupleCheck(String email) async {
    try {
      final response = await apiService.emailDuplicateCheck(email);
      if (response.statusCode == 201) {
        _isEmailCheck = true;
        notifyListeners();
      } else {
        _isEmailCheck = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  bool emailRegexCheck(String email) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$');
    return regex.hasMatch(email);
  }

  Future<void> nickNameDupleCheck(String nickName) async {
    try {
      final response = await apiService.nickNameDuplicateCheck(nickName);
      if (response.statusCode == 201) {
        _nickNameCheck = true;
        notifyListeners();
      } else {
        _nickNameCheck = false;
        print(response.statusCode);
        notifyListeners();
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void sendPhone() {
    _isSendPhone = true;
    notifyListeners();
  }

  Future<void> phoneVerify(String phoneNumber) async {
    try {
      final response = await apiService.phoneVerify(phoneNumber, 1);
      if (response.statusCode == 201) {
        _isSendPhone = true;
        print("phoneVerify: ${response.data}");
        notifyListeners();
      } else {
        _isPhoneCheck = false;
        print("phoneVerify: ${response.statusCode}");
        notifyListeners();
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 400) {
        _isSendPhone = false;
        var severMessage = e.response!.data['message'];
        print("phoneVerify: $severMessage");
      }
      throw e;
    }
  }

  Future<void> phoneVerifyCheck(String phoneNumber, String code) async {
    try {
      final response = await apiService.phoneVerifyCheck(phoneNumber, code, 1);
      if (response.statusCode == 200) {
        phoneToken = response.data['token'];
        print("phoneToken : $phoneToken");

        _isPhoneCheck = true;
        notifyListeners();
      } else {
        _isPhoneCheck = false;
        print("phoneVerifyCheck: ${response.statusCode}");
        notifyListeners();
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 400) {
        _isPhoneCheck = false;
        var severMessage = e.response!.data['message'];
      } else if (e.response!.statusCode == 401) {
        _isPhoneCheck = false;
      } else {
        _isPhoneCheck = false;
      }
    }
  }

  bool passwordCheck(String password, String passwordCheck) {
    if (password == passwordCheck) {
      return true;
    } else {
      return false;
    }
  }

  bool dupleCheck() {
    if (_isEmailCheck && _nickNameCheck && _isPhoneCheck) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> register(String email, String password, String nickName,
      String name, int userType) async {
    try {
      final response = await apiService.register(
          email, phoneToken, password, nickName, name, userType);
      if (response.statusCode == 200) {
        _isRegisterSuccess = true;
        String token = response.data['token'];
        await storage.write(key: "token", value: token);
      } else {
        _isRegisterSuccess = false;
      }
    } on DioException catch (e) {
      print(e.response!.data);
      _isRegisterSuccess = false;
    }
  }

  bool passwordRegexCheck(String password) {
    // /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]/
    RegExp regex =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]');
    return regex.hasMatch(password);
  }
}
