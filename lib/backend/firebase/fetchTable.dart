import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> fetchData(String collection) async {
  CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection(collection);

  QuerySnapshot querySnapshot = await itemsCollection.get();
  return querySnapshot.docs
      .map((doc) => doc.data() as Map<String, dynamic>)
      .toList();
}
