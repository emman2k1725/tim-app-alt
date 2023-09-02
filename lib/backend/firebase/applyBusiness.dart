import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../model/BusinessModel.dart';

Future<String?> uploadImage(Uint8List? image, String? folderName) async {
  String? result;
  try {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('business/$folderName/images/$fileName.jpg');
    await storageReference.putData(image!);
    String imageUrl = await storageReference.getDownloadURL();
    result = imageUrl;
  } catch (e) {
    debugPrint(e.toString());
  }
  return result;
}

Future<String?> applyBusiness(BusinessModel business) async {
  String result = "";
  try {
    final _firestore = FirebaseFirestore.instance.collection('businesses');
    await _firestore.doc().set(business.toMap());
    result = 'success';
  } catch (e) {
    debugPrint(e.toString());
    result = e.toString();
  }
  return result;
}
