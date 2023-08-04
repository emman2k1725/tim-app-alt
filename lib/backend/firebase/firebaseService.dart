import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/UserModel.dart';

Future fetchDocument(String key, String value) async {
  final _firestore = FirebaseFirestore.instance.collection('businesses');
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.where(key, isEqualTo: value).get();
    if (querySnapshot.docs.isNotEmpty) {
      QueryDocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      Map<String, dynamic> documentData =
          documentSnapshot.data() as Map<String, dynamic>;
      return documentData;
    } else {
      throw Exception('Document not found!');
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future fetchDocumentbyID(String? docID, String collection) async {
  final _firestore = FirebaseFirestore.instance.collection(collection);
  try {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.doc(docID).get();
    if (querySnapshot.exists) {
      Map<String, dynamic> documentData =
          querySnapshot.data() as Map<String, dynamic>;
      documentData['docID'] = querySnapshot.id;
      return documentData;
    } else {
      throw Exception('Document not found!');
    }
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

Future updateUserDocument(String? docID, UserModel? userModel) async {
  final _firestore = FirebaseFirestore.instance.collection('user_profile');
  try {
    await _firestore.doc(docID).update(userModel!.toMap());
    return 'success';
  } catch (e) {
    print(e.toString());
    return null;
  }
}
