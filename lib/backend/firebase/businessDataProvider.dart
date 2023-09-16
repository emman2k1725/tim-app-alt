import 'package:flutter/material.dart';
import 'package:tim_app/model/BusinessModel.dart';

class BusinessDataProvider with ChangeNotifier {
  BusinessModel? _businessData;
  BusinessModel? get businessData => _businessData;

  void setData(BusinessModel businessData) {
    _businessData = businessData;
    notifyListeners();
  }
}
