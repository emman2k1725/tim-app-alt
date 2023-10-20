import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tim_app/model/content_model.dart';
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
    }
  } on FirebaseException catch (e) {
    debugPrint(e.message);
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

Future updatedContent(String? docID, ContentModel? contentModel) async {
  final _firestore = FirebaseFirestore.instance.collection('content');
  try {
    await _firestore.doc(docID).update(contentModel!.toMap());

    return 'success';
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<String?> uploadImage(Uint8List? image, String? folderName) async {
  String? result;
  try {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('Content/$folderName/images/$fileName.jpg');
    await storageReference.putData(image!);
    String imageUrl = await storageReference.getDownloadURL();
    result = imageUrl;
  } catch (e) {
    debugPrint(e.toString());
  }
  return result;
}

Future createContent(ContentModel? contentModel) async {
  final _firestore = FirebaseFirestore.instance.collection('content');
  String? result;
  try {
    await _firestore.doc().set(contentModel!.toMap());
    result = 'success';
  } catch (e) {
    result = e.toString();
  }
  return result;
}

Future createAds(Map<String, dynamic> ads, String collectionName) async {
  final _firestore = FirebaseFirestore.instance.collection(collectionName);
  String? result;
  try {
    await _firestore.doc().set(ads);
    result = 'success';
  } catch (e) {
    result = e.toString();
  }
  return result;
}

Future saveItenerary(Map<String, dynamic> iteneraryData) async {
  final _firestore = FirebaseFirestore.instance.collection('travel-history');
  String? result;
  try {
    await _firestore.doc().set(iteneraryData);
    result = 'success';
  } catch (e) {
    result = e.toString();
    debugPrint(result);
  }
  return result;
}

Future updateContent(String? docID, ContentModel? contentModel) async {
  final _firestore = FirebaseFirestore.instance.collection('content');
  try {
    await _firestore.doc(docID).update(contentModel!.toMap());
    return 'success';
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<Map<String, dynamic>> fetchBusiness(String? ownerID) async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('businesses')
        .where('businessOwner', isEqualTo: ownerID)
        .get();
    if (snapshot.docs.isNotEmpty) {
      Map<String, dynamic> data = snapshot.docs.first.data();
      data['businessID'] = snapshot.docs.first.id;
      return data;
    } else {
      return {};
    }
  } catch (e) {
    debugPrint(e.toString());
    return {};
  }
}

Future<List<Map<String, dynamic>>> getBusinessesQuery(
    String interest, String city, String findWhat) async {
  Query query = FirebaseFirestore.instance.collection('businesses');
  if (findWhat == 'Restaurant') {
    query = query
        .where('businessAddress.city', isEqualTo: city)
        .where('businessSector', isEqualTo: findWhat)
        .where('cruisine', isEqualTo: interest)
        .limit(10);
  } else {
    query = query
        .where('businessAddress.city', isEqualTo: city)
        .where('businessSector', isEqualTo: interest)
        .limit(10);
  }
  QuerySnapshot querySnapshot = await query.get();

  List<Map<String, dynamic>> documentsList = [];

  for (var document in querySnapshot.docs) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    if (data.isNotEmpty) {
      data['placeID'] = document.id;
      documentsList.add(data);
    }
  }
  return documentsList;
}
