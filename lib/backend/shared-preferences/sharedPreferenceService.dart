import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../model/UserModel.dart';

class PrefService {
  Future createCache(UserModel user) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString('user', jsonEncode(user.toJson()));
  }

  void reload() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.reload();
  }
}
