import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Firebase Collection
final _collection = FirebaseFirestore.instance.collection('dropdownCollection');

List<String> _dropdownItems = [];

class FirebaseService {
  static Future<List<String>> fetchDropdownItems(String whatCollection) async {
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
}
