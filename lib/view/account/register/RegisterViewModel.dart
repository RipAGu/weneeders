import 'package:flutter/cupertino.dart';

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
      _isAllChecked = true;
    } else {
      _isAllChecked = false;
    }
    notifyListeners();
  }
}
