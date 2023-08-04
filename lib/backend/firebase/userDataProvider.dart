import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/UserModel.dart';

class UserDataProvider with ChangeNotifier {
  UserModel? _userData;
  UserModel? get userData => _userData;

  void setUserData(UserModel user) {
    _userData = user;
    notifyListeners();
  }

  Future<void> loadDataFromSharedPref() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      UserModel? userData =
          UserModel.fromMap(jsonDecode(pref.getString('user')!));
      setUserData(userData);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
