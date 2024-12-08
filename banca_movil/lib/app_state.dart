import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  double _fontSize = 16;
  double _buttonSize = 56;
  final double _maxFontSize = 24;
  final double _maxButtonSize = 72;

  double get fontSize => _fontSize;
  double get buttonSize => _buttonSize;

  void increaseFontSize() {
    if (_fontSize < _maxFontSize) {
      _fontSize += 2;
      notifyListeners();
    }
  }

  void decreaseFontSize() {
    if (_fontSize > 16) {
      _fontSize -= 2;
      notifyListeners();
    }
  }

  void increaseButtonSize() {
    if (_buttonSize < _maxButtonSize) {
      _buttonSize += 4;
      notifyListeners();
    }
  }

  void decreaseButtonSize() {
    if (_buttonSize > 56) {
      _buttonSize -= 4;
      notifyListeners();
    }
  }
}
