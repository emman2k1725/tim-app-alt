import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Firebase Collection
final _collection = FirebaseFirestore.instance.collection('dropdownCollection');

class FirebaseService {
  static Future<List<String>> fetchDropdownItems(String whatCollection) async {
    await Future.delayed(const Duration(seconds: 2));
    final querySnapshot = await FirebaseFirestore.instance
        .collection('dropdownCollection')
        .doc(whatCollection)
        .get();

    if (querySnapshot.exists) {
      final dropdownItems = List<String>.from(querySnapshot.data()?['choices']);
      return dropdownItems;
    }

    return []; // Return an empty list if data is not available
  }

  static Future<List<Map<String, dynamic>>> fetchCities() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('dropdownCollection')
          .doc('cities')
          .get();
      if (querySnapshot.exists) {
        final dropdownItems =
            List<Map<String, dynamic>>.from(querySnapshot.data()?['choices']);
        return dropdownItems;
      }
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  static Future<List<Map<String, dynamic>>> fetchHangout() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('dropdownCollection')
          .doc('hangout')
          .get();
      if (querySnapshot.exists) {
        final dropdownItems =
            List<Map<String, dynamic>>.from(querySnapshot.data()?['choices']);
        return dropdownItems;
      }
    } catch (e) {
      print(e.toString());
    }
    return [];
  }
}
