import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tim_app/model/city_model.dart';
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

Future<String?> uploadReviewImage(Uint8List? image, String? folderName) async {
  String? result;
  try {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('$folderName/${fileName}.jpg');
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

Future<String> createSetting(
    List<Map<String, dynamic>> newData, String document) async {
  final firestore =
      FirebaseFirestore.instance.collection("dropdownCollection").doc(document);
  String result = '';

  try {
    firestore.update({'choices': newData});
    result = 'success';
  } catch (e) {
    result = 'Error: $e';
  }

  return result;
}

Future<String> updateSetting(String newData, String document) async {
  final firestore =
      FirebaseFirestore.instance.collection("dropdownCollection").doc(document);
  String result = '';

  try {
    // Fetch the current "choices" array from Firestore
    final DocumentSnapshot docSnapshot = await firestore.get();
    if (docSnapshot.exists) {
      List<dynamic> currentChoices =
          List<dynamic>.from(docSnapshot['choices'] ?? []);
      // Append the new data to the array
      currentChoices.add(newData);

      // Update the Firestore document with the modified "choices" array
      await firestore.update({'choices': currentChoices});
      result = 'success';
    } else {
      result = 'Document not found';
    }
  } catch (e) {
    result = 'Error: $e';
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

Future<bool> ratePlace(Map<String, dynamic> ratingData) async {
  bool result = false;
  try {
    final _firestore = FirebaseFirestore.instance
        .collection('businesses')
        .doc(ratingData['placeID']);
    _firestore.collection('ratings').add(ratingData);
    //Check if ratings are 0
    bool updateRatingRes =
        await updateRating(ratingData['placeID'], ratingData['rating']);
    result = updateRatingRes;
  } catch (e) {
    debugPrint(e.toString());
  }
  return result;
}

Future<bool> updateRating(String docID, double rating) async {
  bool result = false;
  final _firestore =
      FirebaseFirestore.instance.collection('businesses').doc(docID);
  try {
    DocumentSnapshot<Map<String, dynamic>> doc = await _firestore.get();
    if (doc.data()?['rating'] is String) {
      double ratingVal = double.parse(doc.data()?['rating']);
      bool incRes = await increment(ratingVal, rating, docID);
      result = incRes;
    } else {
      double ratingVal = doc.data()?['rating'];
      bool incRes = await increment(ratingVal, rating, docID);
      result = incRes;
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return result;
}

Future<bool> increment(double ratingVal, double rating, String docID) async {
  final _firestore =
      FirebaseFirestore.instance.collection('businesses').doc(docID);
  bool flag = false;
  if (ratingVal == 0.0 || ratingVal == 0) {
    ratingVal = (ratingVal + rating) / 1;
    _firestore
        .update({"reviewCount": FieldValue.increment(1), "rating": ratingVal});
    flag = true;
  } else {
    ratingVal = (ratingVal + rating) / 2;
    _firestore
        .update({"reviewCount": FieldValue.increment(1), "rating": ratingVal});
    flag = true;
  }
  return flag;
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

Future updateBusinessContent(
    String docID, String collectionName, String status) async {
  final _firestore = FirebaseFirestore.instance.collection(collectionName);

  debugPrint(docID);
  try {
    Map<String, dynamic> dataToUpdate = {
      'status': status,
    };

    await _firestore.doc(docID).update(dataToUpdate);
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

Future<bool> updateItenerary(dynamic itenerary, String docID) async {
  List<Map<String, dynamic>> finalItenerary = [];
  for (int x = 0; x < itenerary.length; x++) {
    finalItenerary.add(itenerary[x]);
  }
  final _firestore =
      FirebaseFirestore.instance.collection('travel-history').doc(docID);
  try {
    _firestore.update({"itenerary": finalItenerary}).catchError((error) {
      debugPrint(error.toString());
    });
    return true;
  } catch (e) {
    return false;
  }
}
