import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<QuerySnapshot<Map<String, dynamic>>> getScores() async {
    return FirebaseFirestore.instance
        .collection('scores')
        .limit(10)
        .orderBy('score', descending: true)
        .get();
  }

  Future<void> addScore(String username, int score) async {
    await FirebaseFirestore.instance.collection('scores').add(
      {
        'username': username,
        'score': score,
        'timestamp': Timestamp.now(),
      },
    );
  }

  Future<void> createUserData(String email, String username) async {
    await FirebaseFirestore.instance.collection('users').doc(email).set(
      {
        'username': username,
        'score': 0,
      },
    );
  }

  Future<void> updateUserData(String email, String field, dynamic data) async {
    await FirebaseFirestore.instance.collection('users').doc(email).update(
      {field: data},
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(
      String email) async {
    return FirebaseFirestore.instance.collection('users').doc(email).get();
  }

  Future<void> clear() async {
    await FirebaseFirestore.instance.terminate();
    await FirebaseFirestore.instance.clearPersistence();
  }
}
