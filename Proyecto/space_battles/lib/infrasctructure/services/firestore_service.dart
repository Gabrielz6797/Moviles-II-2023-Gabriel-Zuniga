import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<QuerySnapshot<Map<String, dynamic>>> getScores(
      String collectionPath) async {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy('timestamp', descending: true)
        .get();
  }

  Future<void> addScore(String collectionPath, String email, int score) async {
    await FirebaseFirestore.instance.collection(collectionPath).add(
      {
        'email': email,
        'score': score,
        'timestamp': Timestamp.now(),
      },
    );
  }

  Future<void> createUserData(
      String collectionPath, String email, String username) async {
    await FirebaseFirestore.instance.collection(collectionPath).doc(email).set(
      {
        'username': username,
        'score': 0,
      },
    );
  }

  Future<void> updateUserData(
      String collectionPath, String email, String field, dynamic data) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(email)
        .update(
      {field: data},
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(
      String collectionPath, String email) async {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(email)
        .get();
  }

  Future<void> clear() async {
    await FirebaseFirestore.instance.terminate();
    await FirebaseFirestore.instance.clearPersistence();
  }
}
