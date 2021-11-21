import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class FcmHelper {
  FcmHelper._();
  static FcmHelper fcmHelper = FcmHelper._();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  generateFcmToken() async {
    String fcmToken = await messaging.getToken();
    messaging.subscribeToTopic('students');
  }

  fcmInitialize(BuildContext context) async {
    String fcmToken = await messaging.getToken();
    log('//////////////');
    log(fcmToken);
    //////////////////////////////
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log(message.notification.title);
      log(message.data.toString());
      Get.dialog(AlertDialog(
        title: Text('new order has been recived'),
        content: Text('this is order body'),
      ));
      // showNotification(message.notification.title, message.notification.body,
      //     message.data['page']);

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  ////////////////////////////////////////
  localNotifictionInit() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  showNotification(String title, String body, String pageName) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: pageName);
  }

  void selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }
}
