import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/auth/helpers/auth_helper.dart';
import 'package:firebase_project/auth/helpers/firebase_storage_helper.dart';
import 'package:firebase_project/auth/helpers/firestore_helper.dart';
import 'package:firebase_project/auth/models/register_request.dart';
import 'package:firebase_project/auth/ui/home_screen.dart';
import 'package:firebase_project/auth/ui/sign_up_screen.dart';
import 'package:firebase_project/ecommerce/models/product_request.dart';
import 'package:firebase_project/helpers.dart';
import 'package:firebase_project/splach_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum Gender { male, female }
enum UserType { mershant, customer }

class AuthProvider extends ChangeNotifier {
  int selectedIndex = 0;
  RegisterRequest registerRequest;
  changeindex(int index) {
    this.selectedIndex = index;
    notifyListeners();
  }

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

  Future<bool> checkUser() async {
    isLogged = AuthHelper.authHelper.checkUser();
    if (isLogged) {
      this.registerRequest =
          await getUserBasedOnId(FirebaseAuth.instance.currentUser.uid);
    }
    notifyListeners();
    return isLogged;
  }

  gotoHome() {
    Get.off(HomeScreen());
  }

  createUser(RegisterRequest registerRequest) async {
    EasyLoading.show(status: 'Registering...');
    UserCredential userCredential = await AuthHelper.authHelper
        .registerUsingEmailAndPassword(
            registerRequest.email, registerRequest.password);
    registerRequest.userId = userCredential.user.uid;
    FirestoreHelper.firestoreHelper.saveUserInFirestore(registerRequest);
    EasyLoading.dismiss();

    Helpers.helpers.showDialoug(
        'success',
        'your user has been successfully registerd, press ok to go to home page',
        gotoHome);
  }

  getUser(String email, String password) async {
    UserCredential userCredential = await AuthHelper.authHelper
        .signInUsingEmailAndPassword(email, password);
    if (userCredential != null) {
      RegisterRequest registerRequest =
          await getUserBasedOnId(userCredential.user.uid);
      if (registerRequest.isMershant) {
        getMershantProducts();
      }
      Get.off(HomeScreen());
    }
  }

  Future<RegisterRequest> getUserBasedOnId(String userId) async {
    Map map =
        await FirestoreHelper.firestoreHelper.getUserFromFirestore(userId);
    RegisterRequest registerRequest = RegisterRequest.fromMap(map);
    this.registerRequest = registerRequest;
    getMershantProducts();
    return registerRequest;
  }

  File pickedFile;
  uploadImageUrl() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    pickedFile = File(file.path);
    notifyListeners();
  }

  editProfile() async {
    String imageUrl;
    if (pickedFile != null) {
      imageUrl = await FirebaseStorageHelper.firebaseStorageHelper
          .uploadImage(File(pickedFile.path));
    }
    Map<String, dynamic> map = imageUrl == null
        ? {
            'fName': firstNameController.text,
            'lName': lastNameController.text,
            'gender': selectedGender == Gender.male ? 1 : 0,
          }
        : {
            'fName': firstNameController.text,
            'lName': lastNameController.text,
            'gender': selectedGender == Gender.male ? 1 : 0,
            'imageUrl': imageUrl
          };
    FirestoreHelper.firestoreHelper
        .updateUser(map, this.registerRequest.userId);
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  setEditPageFields() {
    firstNameController.text = this.registerRequest.fName;
    lastNameController.text = this.registerRequest.lName;
    this.selectedGender = this.registerRequest.gender;
    notifyListeners();
  }

  List<ProductRequest> products;
  getMershantProducts() async {
    String mershantId = FirebaseAuth.instance.currentUser.uid;
    products = await FirestoreHelper.firestoreHelper
        .getAllProductsForMershant(mershantId);

    notifyListeners();
  }
}
