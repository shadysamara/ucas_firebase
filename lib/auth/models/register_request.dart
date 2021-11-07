import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:firebase_project/auth/providers/auth_provider.dart';

class RegisterRequest {
  String userId;
  String fName;
  String lName;
  String email;
  String password;
  Gender gender;
  bool isMershant;
  String marketId;
  RegisterRequest(
      {this.userId,
      @required this.fName,
      @required this.lName,
      @required this.email,
      @required this.password,
      @required this.gender,
      this.marketId,
      this.isMershant});

  Map<String, dynamic> toMap() {
    return isMershant
        ? {
            'userId': this.userId,
            'fName': fName,
            'lName': lName,
            'email': email,
            'marketId': this.marketId,
            'isMershant': isMershant,
            'gender': gender == Gender.male ? 1 : 0
          }
        : {
            'userId': this.userId,
            'fName': fName,
            'lName': lName,
            'email': email,
            'isMershant': isMershant,
            'gender': gender == Gender.male ? 1 : 0
          };
  }

  factory RegisterRequest.fromMap(Map<String, dynamic> map) {
    return RegisterRequest(
        userId: map['userId'],
        fName: map['fName'],
        isMershant: map['isMershant'],
        lName: map['lName'],
        marketId: map['marketId'],
        email: map['email'],
        gender: map['gender'] == 1 ? Gender.male : Gender.female);
  }
}
