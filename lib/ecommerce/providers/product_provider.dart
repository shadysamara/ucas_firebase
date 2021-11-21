import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/ecommerce/models/product_request.dart';
import 'package:firebase_project/ecommerce/respositories/ecommerce_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductProvider extends ChangeNotifier {
  File pickedFile;
  TextEditingController productName = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController productQuantity = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  List<ProductRequest> products;
  String validateNull(String value) {
    if (value == null || value.isEmpty) {
      return 'required field';
    } else {
      return null;
    }
  }

  pickImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    pickedFile = File(file.path);
    notifyListeners();
  }

  addProduct() async {
    if (pickedFile == null) {
      log('you have t0 choose image');
    } else {
      EasyLoading.show(status: 'uploading...');
      String imageUrl =
          await EcommerceHelper.ecommerceHelper.uploadImage(pickedFile);
      ProductRequest productRequest = ProductRequest(
          price: productPrice.text,
          productDescription: productDescription.text,
          productName: productName.text,
          quantity: productQuantity.text,
          imageUrl: imageUrl);
      bool isAdded =
          await EcommerceHelper.ecommerceHelper.addProduct(productRequest);
      EasyLoading.dismiss();
      Get.dialog(CupertinoAlertDialog(
        title: Text('success'),
        content: Text('your product has been successfully added'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('ok'))
        ],
      ));
    }
  }

  updateProduct(String productId) async {
    String imageUrl;
    if (this.pickedFile != null) {
      imageUrl = await EcommerceHelper.ecommerceHelper.uploadImage(pickedFile);
    }
    ProductRequest productRequest = ProductRequest(
        price: productPrice.text,
        productDescription: productDescription.text,
        productName: productName.text,
        quantity: productQuantity.text,
        imageUrl: imageUrl);
    await EcommerceHelper.ecommerceHelper
        .editProduct(productRequest, productId);
    getAllProducts();
  }

  getAllProducts() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
        await EcommerceHelper.ecommerceHelper.getAllProducts();
    this.products = docs.map((e) {
      Map<String, dynamic> map = e.data();
      map['id'] = e.id;
      return ProductRequest.fromMap(map);
    }).toList();
    notifyListeners();
  }

  deleteProduct(String productId) async {
    await EcommerceHelper.ecommerceHelper.deleteProduct(productId);
    getAllProducts();
  }
}
