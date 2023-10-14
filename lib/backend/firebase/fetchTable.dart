import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<List<Map<String, dynamic>>> fetchData(String collection) async {
  CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection(collection);

  QuerySnapshot querySnapshot = await itemsCollection.get();
  List<Map<String, dynamic>> data = [];

  for (var document in querySnapshot.docs) {
    String docID = document.id;
    Map<String, dynamic> documentData =
        (document.data() as Map<String, dynamic>);
    documentData['docID'] = docID;
    data.add(documentData);
  }
  return data;
}

Future<List<Map<String, dynamic>>> fetchTravel(String? userID) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('travel-history')
      .where('ownedBy', isEqualTo: userID)
      .get();

  List<Map<String, dynamic>> dataList = [];

  querySnapshot.docs.forEach((doc) {
    String documentID = doc.id;
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    data['docID'] = documentID; // Add documentID to the data map

    dataList.add(data);
  });
  return dataList;
}

Stream<List<Map<String, dynamic>>> fetchSpecialOffer(String? businessID) {
  Query<Map<String, dynamic>> itemsCollection = FirebaseFirestore.instance
      .collection('special_offers')
      .where("business", isEqualTo: businessID);

  return itemsCollection.snapshots().map((querySnapshot) {
    List<Map<String, dynamic>> data = [];

    for (var document in querySnapshot.docs) {
      String docID = document.id;
      Map<String, dynamic> documentData = document.data();
      documentData['docID'] = docID;
      data.add(documentData);
    }
    return data;
  });
}

Stream<List<Map<String, dynamic>>> fetchAds(String? businessID) {
  Query<Map<String, dynamic>> itemsCollection = FirebaseFirestore.instance
      .collection('advertisement')
      .where("business", isEqualTo: businessID);

  return itemsCollection.snapshots().map((querySnapshot) {
    List<Map<String, dynamic>> data = [];

    for (var document in querySnapshot.docs) {
      String docID = document.id;
      Map<String, dynamic> documentData = document.data();
      documentData['docID'] = docID;
      data.add(documentData);
    }
    return data;
  });
}

Future<List<Map<String, dynamic>>> fetchTableNews(String type) async {
  Query<Map<String, dynamic>> itemsCollection = FirebaseFirestore.instance
      .collection('content')
      .where("contentType", isEqualTo: type);

  QuerySnapshot querySnapshot = await itemsCollection.get();
  List<Map<String, dynamic>> data = [];

  for (var document in querySnapshot.docs) {
    String docID = document.id;
    Map<String, dynamic> documentData =
        (document.data() as Map<String, dynamic>);
    documentData['docID'] = docID;
    data.add(documentData);
  }
  return data;
}

Stream<QuerySnapshot> fetchTableContent(String type) {
  Query<Map<String, dynamic>> itemsCollection = FirebaseFirestore.instance
      .collection('content')
      .where("contentType", isEqualTo: type);
  return itemsCollection.snapshots();
}

Stream<List<Map<String, dynamic>>> fetchTableBusiness(String collection) {
  Query<Map<String, dynamic>> itemsCollection = FirebaseFirestore.instance
      .collection('businesses')
      .where("status", isEqualTo: collection);

  return itemsCollection.snapshots().map((querySnapshot) {
    List<Map<String, dynamic>> data = [];

    for (var document in querySnapshot.docs) {
      String docID = document.id;
      Map<String, dynamic> documentData = document.data();
      documentData['docID'] = docID;
      data.add(documentData);
    }
    return data;
  });
}

Stream<List<Map<String, dynamic>>> fetchTableAdminAccount(bool accessLevel) {
  Query<Map<String, dynamic>> itemsCollection = FirebaseFirestore.instance
      .collection('user_profile')
      .where("isAdmin", isEqualTo: accessLevel);

  return itemsCollection.snapshots().map((querySnapshot) {
    List<Map<String, dynamic>> data = [];

    for (var document in querySnapshot.docs) {
      String docID = document.id;
      Map<String, dynamic> documentData = document.data();
      documentData['docID'] = docID;
      data.add(documentData);
    }
    return data;
  });
}

Stream<List<Map<String, dynamic>>> fetchDataAsStream(String collection) {
  CollectionReference itemsCollection = FirebaseFirestore.instance
      .collection('businesses')
      .where("status", isEqualTo: collection) as CollectionReference<Object?>;

  return itemsCollection.snapshots().map((querySnapshot) {
    List<Map<String, dynamic>> data = [];

    for (var document in querySnapshot.docs) {
      String docID = document.id;
      Map<String, dynamic> documentData =
          document.data() as Map<String, dynamic>;
      documentData['docID'] = docID;
      data.add(documentData);
    }

    return data;
  });
}

Future<String> businessPendingAction(String docID, String action) async {
  CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('businesses');
  String result = "";
  try {
    await itemsCollection.doc(docID).update({'status': action});
    result = 'success';
  } catch (e) {
    result = e.toString();
  }
  return result;
}

Stream<List<Map<String, dynamic>>> fetchCitiesStream() {
  return FirebaseFirestore.instance
      .collection('dropdownCollection')
      .doc('cities')
      .snapshots()
      .map((querySnapshot) {
    if (querySnapshot.exists) {
      return List<Map<String, dynamic>>.from(querySnapshot.data()?['choices']);
    } else {
      return <Map<String, dynamic>>[];
    }
  });
}

Stream<List<Map<String, dynamic>>> fetchTravellerTypeStream() {
  return FirebaseFirestore.instance
      .collection('dropdownCollection')
      .doc('travellerType')
      .snapshots()
      .map((querySnapshot) {
    if (querySnapshot.exists) {
      return List<Map<String, dynamic>>.from(querySnapshot.data()?['choices']);
    } else {
      return <Map<String, dynamic>>[];
    }
  });
}

Stream<List<Map<String, dynamic>>> fetchHangoutStream() {
  return FirebaseFirestore.instance
      .collection('dropdownCollection')
      .doc('hangout')
      .snapshots()
      .map((querySnapshot) {
    if (querySnapshot.exists) {
      return List<Map<String, dynamic>>.from(querySnapshot.data()?['choices']);
    } else {
      return <Map<String, dynamic>>[];
    }
  });
}

Stream<List<Map<String, dynamic>>> fetchCruisinesStream() {
  List<Map<String, dynamic>> data = [];
  Map<String, dynamic> dataString = {};
  return FirebaseFirestore.instance
      .collection('dropdownCollection')
      .doc('cruisines')
      .snapshots()
      .map((querySnapshot) {
    if (querySnapshot.exists) {
      for (int x = 0;
          x < List<String>.from(querySnapshot.data()?['choices']).length;
          x++) {
        dataString = {
          'cruisine': List<String>.from(querySnapshot.data()?['choices'])[x]
        };
        data.add(dataString);
      }
      return data;
    } else {
      return data;
    }
  });
}
