import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<QuerySnapshot<Map<String, dynamic>>> getPosts(
      String collectionPath) async {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy('timestamp', descending: true)
        .get();
  }

  Future<void> addPost(
      String collectionPath, String email, String message) async {
    await FirebaseFirestore.instance.collection(collectionPath).add(
      {
        'email': email,
        'message': message,
        'timestamp': Timestamp.now(),
        'likes': [],
      },
    );
  }

  void likePost(String collectionPath, String id, String email, bool isLiked) {
    DocumentReference postRef =
        FirebaseFirestore.instance.collection(collectionPath).doc(id);
    if (isLiked) {
      postRef.update(
        {
          'likes': FieldValue.arrayUnion([email]),
        },
      );
    } else {
      postRef.update(
        {
          'likes': FieldValue.arrayRemove([email]),
        },
      );
    }
  }

  Future<void> createUserData(
      String collectionPath, String email, String username, String bio) async {
    await FirebaseFirestore.instance.collection(collectionPath).doc(email).set(
      {'username': username, 'bio': bio},
    );
  }

  Future<void> updateUserData(
      String collectionPath, String email, String field, String data) async {
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
