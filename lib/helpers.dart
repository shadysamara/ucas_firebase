import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helpers {
  Helpers._();
  static Helpers helpers = Helpers._();
  showDialoug(String title, String body, Function fun) {
    Get.dialog(CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
            onPressed: () {
              fun();
            },
            child: Text('ok'))
      ],
    ));
  }
}
