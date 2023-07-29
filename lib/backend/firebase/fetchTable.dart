import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getPaginatedDataStream(int itemsPerPage) {
    return _firestore
        .collection('your_collection')
        .limit(itemsPerPage)
        .snapshots();
  }
}
