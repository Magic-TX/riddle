import 'package:flutter/foundation.dart';

class VibrationSettings extends ChangeNotifier {
  bool _isVibrationEnabled = true;

  bool get isVibrationEnabled => _isVibrationEnabled;

  void toggleVibration() {
    _isVibrationEnabled = !_isVibrationEnabled;
    notifyListeners();
  }

  void setVibration(bool value) {
    _isVibrationEnabled = value;
    notifyListeners();
  }
}
