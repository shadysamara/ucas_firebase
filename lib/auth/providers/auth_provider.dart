import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/auth/helpers/auth_helper.dart';
import 'package:firebase_project/auth/helpers/firestore_helper.dart';
import 'package:firebase_project/auth/models/register_request.dart';
import 'package:firebase_project/auth/ui/home_screen.dart';
import 'package:firebase_project/auth/ui/sign_up_screen.dart';
import 'package:firebase_project/splach_screen.dart';
import 'package:flutter/material.dart';

enum Gender { male, female }
enum UserType { mershant, customer }

class AuthProvider extends ChangeNotifier {
  Gender selectedGender;
  UserType selectedUserType;
  selectUserType(UserType userType) {
    this.selectedUserType = userType;
    notifyListeners();
  }

  selectGender(Gender gender) {
    this.selectedGender = gender;
    notifyListeners();
  }

  User user;
  UserCredential userCredential;
  bool isLogged = false;

  login(String email, String password, BuildContext context) async {
    userCredential = await AuthHelper.authHelper
        .signInUsingEmailAndPassword(email, password);

    notifyListeners();
    if (userCredential != null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Dialog Title'),
                content: Text('This is my content'),
              ));
    }
  }

  register(String email, String password, BuildContext context) async {
    try {
      userCredential = await AuthHelper.authHelper
          .registerUsingEmailAndPassword(email, password);
      notifyListeners();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  logOut(BuildContext context) async {
    AuthHelper.authHelper.logot();
    user = null;
    userCredential = null;
    notifyListeners();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return SplachScreen();
    }));
  }

  bool checkUser() {
    isLogged = AuthHelper.authHelper.checkUser();
    notifyListeners();
    return isLogged;
  }

  createUser(RegisterRequest registerRequest) async {
    UserCredential userCredential = await AuthHelper.authHelper
        .registerUsingEmailAndPassword(
            registerRequest.email, registerRequest.password);
    registerRequest.userId = userCredential.user.uid;
    FirestoreHelper.firestoreHelper.saveUserInFirestore(registerRequest);
  }

  getUser(String email, String password) async {
    UserCredential userCredential = await AuthHelper.authHelper
        .signInUsingEmailAndPassword(email, password);
    Map map = await FirestoreHelper.firestoreHelper
        .getUserFromFirestore(userCredential.user.uid);
    RegisterRequest registerRequest = RegisterRequest.fromMap(map);
    log(registerRequest.toMap().toString());
  }
}
