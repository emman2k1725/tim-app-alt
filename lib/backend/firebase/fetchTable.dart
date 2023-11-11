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

Stream<List<Map<String, dynamic>>> getRecentReviews(String? userID) {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore
        .collectionGroup('ratings')
        .where('idOfRater', isEqualTo: userID)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Map<String, dynamic>> list = [];

      querySnapshot.docs.forEach((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        list.add(data);
      });

      return list;
    });
  } catch (e) {
    // Handle any potential errors here
    print("Error: $e");
    return Stream.value([]); // Return an empty stream in case of error
  }
}

Stream<List<Map<String, dynamic>>> fetchAds(String? status) {
  Query<Map<String, dynamic>> itemsCollection = FirebaseFirestore.instance
      .collection('advertisement')
      .where("status", isEqualTo: status);

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

Stream<List<Map<String, dynamic>>> fetchOffers(status) {
  Query<Map<String, dynamic>> itemsCollection = FirebaseFirestore.instance
      .collection('special_offers')
      .where("status", isEqualTo: status);

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

Stream<List<Map<String, dynamic>>> fetchTableCollection(String? collection) {
  Query<Map<String, dynamic>> itemsCollection =
      FirebaseFirestore.instance.collection(collection!);

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

Stream<List<Map<String, dynamic>>> fetchTransaction(
    String collection, String documentID) {
  Query<Map<String, dynamic>> itemsCollection = FirebaseFirestore.instance
      .collection(collection)
      .where("business", isEqualTo: documentID);
  return itemsCollection.snapshots().map((querySnapshot) {
    List<Map<String, dynamic>> data = [];

    for (var document in querySnapshot.docs) {
      Map<String, dynamic> documentData = document.data();
      data.add(documentData);
    }
    return data;
  });
}

Future<String> queryBusinessStatus(businessID) async {
  final CollectionReference businessesCollection =
      FirebaseFirestore.instance.collection('businesses');
  try {
    QuerySnapshot querySnapshot = await businessesCollection
        .where(FieldPath.documentId, isEqualTo: businessID)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      QueryDocumentSnapshot doc = querySnapshot.docs.first;
      String status = doc['status'];

      switch (status) {
        case 'pending':
          return 'Pending';
        case 'approved':
          return 'Approved';
        case 'declined':
          return 'Declined';
        default:
          return 'Unknown Status'; // Handle other status values if needed
      }
    } else {
      return 'No documents found matching the query.';
    }
  } catch (e) {
    return 'Error querying Firestore: $e';
  }
}

// Stream<List<Map<String, dynamic>>?> fetchDataForBusiness(String businessId) {
//   final CollectionReference businessCollection =
//       FirebaseFirestore.instance.collection('business');
//   final CollectionReference dataCollection =
//       FirebaseFirestore.instance.collection('data');

//   return businessCollection
//       .doc(businessId)
//       .snapshots()
//       .asyncMap((businessSnapshot) {
//     if (!businessSnapshot.exists) {
//       return null; // Business document doesn't exist, return null or handle as needed
//     }

//     final businessData = businessSnapshot.data();
//     if (businessData == null || !businessData.containsKey('businessId')) {
//       return null; // Business document is missing 'businessId', return null or handle as needed
//     }

//     final String businessId = businessData['businessId'];

//     return dataCollection
//         .where('businessId', isEqualTo: businessId)
//         .get()
//         .then((querySnapshot) {
//       final data = querySnapshot.docs.map((doc) => doc.data()).toList();
//       return data;
//     });
//   });
// }

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

Stream<List<Map<String, dynamic>>> fetchTableContentNews(String type) {
  Query<Map<String, dynamic>> itemsCollection = FirebaseFirestore.instance
      .collection('content')
      .where("contentType", isEqualTo: type);

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

Stream<List<Map<String, dynamic>>> fetchTableBusiness(String collection) {
  Query<Map<String, dynamic>> itemsCollection = FirebaseFirestore.instance
      .collection('businesses')
      .where("status", isEqualTo: collection);

  return itemsCollection.snapshots().asyncMap((querySnapshot) async {
    List<Map<String, dynamic>> data = [];

    for (var document in querySnapshot.docs) {
      String docID = document.id;
      Map<String, dynamic> documentData = document.data();
      documentData['docID'] = docID;

      // Fetch the ratings subcollection for the current business
      QuerySnapshot ratingsSnapshot =
          await document.reference.collection('ratings').get();
      List<Object?> ratingsData = ratingsSnapshot.docs.map((ratingDoc) {
        return ratingDoc.data();
      }).toList();

      documentData['ratings'] = ratingsData;

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
