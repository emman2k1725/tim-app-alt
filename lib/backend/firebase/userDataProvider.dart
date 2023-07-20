import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/UserModel.dart';

class UserDataProvider with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance.collection('user_profile');
  UserModel? _userData;
  UserModel? get userData => _userData;

  void setUserData(UserModel user) {
    _userData = user;
    notifyListeners();
  }

  Future getUserInfo(String userID) async {
    String result = "";
    try {
      DocumentSnapshot userSnapshot = await _firestore.doc(userID).get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromMap(userData);
        setUserData(user);
        result = "success";
      }
    } catch (e) {
      result = e.toString();
    }

    return result;
  }
}
