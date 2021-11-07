import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/auth/models/register_request.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  saveUserInFirestore(RegisterRequest registerRequest) {
    firestore
        .collection('users')
        .doc(registerRequest.userId)
        .set(registerRequest.toMap());
  }

  Future<Map> getUserFromFirestore(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firestore.collection('users').doc(userId).get();
    Map map = documentSnapshot.data();
    return map;
  }
}