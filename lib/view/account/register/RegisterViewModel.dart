import 'package:flutter/cupertino.dart';

class RegisterViewModel extends ChangeNotifier {
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
    notifyListeners();
  }

  void setServiceCheck(bool value) {
    _isServiceCheck = value;
    notifyListeners();
  }

  void setPrivacyCheck(bool value) {
    _isPrivacyCheck = value;
    notifyListeners();
  }

  void setMarketingCheck(bool value) {
    _isMarketingCheck = value;
    notifyListeners();
  }

  bool isAllCheckedValue() {
    if (_isTotalCheck &&
        _isServiceCheck &&
        _isPrivacyCheck &&
        _isMarketingCheck) {
      return true;
    } else {
      return false;
    }
  }
}
