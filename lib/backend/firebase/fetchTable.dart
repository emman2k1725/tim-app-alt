import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> fetchData(String collection) async {
  CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('businesses');

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

businessPendingAction(String docID, String action) async {
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
