import "package:flutter/material.dart";

class BaseViewState with ChangeNotifier {
  bool _isLoading = false;
  bool _hasError = false;

  BaseViewState();

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  set isLoading(bool value) {
    _hasError = false;
    _isLoading = value;
    notifyListeners();
  }

  set hasError(bool value) {
    _hasError = value;
    _isLoading = false;
    notifyListeners();
  }
}
