import 'package:cloud_firestore/cloud_firestore.dart';

class HomeProvider {
  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    await _usersCollection.doc(userId).set(data);
  }

  Future<DocumentSnapshot<Object?>> getUserData(String userId) async {
    final documentSnapshot = await _usersCollection.doc(userId).get();
    return documentSnapshot;
  }

  Stream<QuerySnapshot<Object?>> getUsersSnapshot() {
    return _usersCollection.snapshots();
  }
}
