import 'package:flutter/foundation.dart';

class EntitlementState extends ChangeNotifier {
  bool _isAdsFree;

  EntitlementState({bool initialAdsFree = false}) : _isAdsFree = initialAdsFree;

  bool get isAdsFree => _isAdsFree;

  void setAdsFree(bool value) {
    if (_isAdsFree != value) {
      _isAdsFree = value;
      notifyListeners();
    }
  }
}
