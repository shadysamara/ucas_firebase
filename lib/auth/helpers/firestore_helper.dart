import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/auth/models/register_request.dart';
import 'package:firebase_project/ecommerce/models/product_request.dart';

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

  updateUser(Map map, String userId) async {
    await firestore.collection('users').doc(userId).update(map);
    log('done');
  }

  Future<List<ProductRequest>> getAllProductsForMershant(
      String mershantId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('products')
        .where('mershantId', isEqualTo: mershantId)
        .get();
    List<ProductRequest> products = querySnapshot.docs.map((e) {
      Map map = e.data();
      map['id'] = e.id;
      return ProductRequest.fromMap(map);
    }).toList();
    return products;
  }
}
