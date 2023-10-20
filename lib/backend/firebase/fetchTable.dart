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

Stream<List<Map<String, dynamic>>> fetchTravel(String? userID) {
  Query<Map<String, dynamic>> itemsCollection = FirebaseFirestore.instance
      .collection('travel-history')
      .where("ownedBy", isEqualTo: userID);

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

Stream<List<Map<String, dynamic>>> fetchChoicesStream(String documentName) {
  return FirebaseFirestore.instance
      .collection('dropdownCollection')
      .doc(documentName) // Replace with the correct document name
      .snapshots()
      .map((querySnapshot) {
    if (querySnapshot.exists) {
      final List<String> choices =
          List<String>.from(querySnapshot.data()?['choices'] ?? []);

      // Map the List of strings to List of Maps
      final transformedData = choices.map((choice) {
        return {
          'choice': choice,
        };
      }).toList();

      return transformedData;
    } else {
      return <Map<String, dynamic>>[];
    }
  });
}
