import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tim_app/model/BusinessModel.dart';

class BusinessDataProvider with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  BusinessModel? _businessData;
  BusinessModel? get businessData => _businessData;

  void setUserData(BusinessModel businessData) {
    _businessData = businessData;
    notifyListeners();
  }
}
