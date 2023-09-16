import 'package:flutter/foundation.dart';

/*class NavBarProvider extends ChangeNotifier {
  String _isSelected = '';

  String get isSelected => _isSelected;

  void setSelected(String selected) {
    _isSelected = selected;
    notifyListeners();
  }
}*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// this code is to stay on the same page after reloading
class NavBarProvider extends ChangeNotifier {
  String _isSelected = '';

  String get isSelected => _isSelected;

  NavBarProvider() {
    // Initialize the selected item from storage when the provider is created.
    _loadSelectedFromStorage();
  }

  void _loadSelectedFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedSelected = prefs.getString('selectedItem') ??
        ''; // Use a default value if none is stored
    _isSelected = storedSelected;
    notifyListeners();
  }

  Future<void> setSelected(String selected) async {
    // Update the selected item and save it to storage
    _isSelected = selected;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedItem', selected);
  }
}
