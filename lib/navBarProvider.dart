import 'package:flutter/foundation.dart';

class NavBarProvider extends ChangeNotifier {
  String _isSelected = '';

  String get isSelected => _isSelected;

  void setSelected(String selected) {
    _isSelected = selected;
    notifyListeners();
  }
}
