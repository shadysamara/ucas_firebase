import 'dart:convert';

import 'package:flutter/material.dart';

class ProductRequest {
  String productId;
  String productName;
  String productDescription;
  String price;
  String imageUrl;
  String quantity;
  String mershantId;
  ProductRequest({
    this.productId,
    this.mershantId,
    @required this.productName,
    @required this.productDescription,
    @required this.price,
    @required this.imageUrl,
    @required this.quantity,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'productName': productName,
      'productDescription': productDescription,
      'mershantId': mershantId,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'productId': productId,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  factory ProductRequest.fromMap(Map<String, dynamic> map) {
    return ProductRequest(
        productName: map['productName'],
        productDescription: map['productDescription'],
        price: map['price'],
        imageUrl: map['imageUrl'],
        quantity: map['quantity'],
        mershantId: map['mershantId'],
        productId: map['id']);
  }
}
