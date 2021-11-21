import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/ecommerce/models/product_request.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EcommerceHelper {
  EcommerceHelper._();
  static final EcommerceHelper ecommerceHelper = EcommerceHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final String collectionName = 'products';
  final String storagePath = 'products';
//////////////////////////////////////////////
  Future<String> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    Reference ref = firebaseStorage.ref('$storagePath/' + fileName);
    await ref.putFile(file);
    String imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }

  //////////////////////////////////////////////
  Future<bool> addProduct(ProductRequest productRequest) async {
    try {
      await firestore.collection(collectionName).add(productRequest.toMap());

      return true;
    } on Exception catch (e) {
      return false;
    }
  }

//////////////////////////////////////////////
  Future<bool> editProduct(
      ProductRequest productRequest, String productId) async {
    try {
      await firestore
          .collection(collectionName)
          .doc(productId)
          .update(productRequest.toMap());
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

//////////////////////////////////////////////
  Future<bool> deleteProduct(String productId) async {
    try {
      await firestore.collection(collectionName).doc(productId).delete();
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

//////////////////////////////////////////////
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAllProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestore.collection(collectionName).get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
          querySnapshot.docs;
      return docs;
    } on Exception catch (e) {
      return null;
    }
  }

//////////////////////////////////////////////
  Future<DocumentSnapshot<Map<String, dynamic>>> getOneProduct(
      String productId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> document =
          await firestore.collection(collectionName).doc(productId).get();
      return document;
    } on Exception catch (e) {
      return null;
    }
  }
}
