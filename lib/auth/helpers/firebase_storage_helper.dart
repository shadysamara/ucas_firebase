import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  FirebaseStorageHelper._();
  static FirebaseStorageHelper firebaseStorageHelper =
      FirebaseStorageHelper._();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    Reference ref = firebaseStorage.ref('images/' + fileName);
    await ref.putFile(file);
    String imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }
}
