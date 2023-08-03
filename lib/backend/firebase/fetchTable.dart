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
