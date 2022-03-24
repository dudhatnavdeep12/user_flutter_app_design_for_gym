import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:user_gym_app/utility/common_methods.dart';

class FirebaseNotificationService {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  static initializeService() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      if (message.notification != null) {
        PushNotificationModel model = PushNotificationModel();
        model.title = message.notification!.title;
        model.body = message.notification!.body;
        model.data = message.data;
        showNotification(model);
      } else {
        PushNotificationModel model = PushNotificationModel();
        model.title = message.data["title"];
        model.title = message.data["body"];
        model.data = message.data;
        showNotification(model);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      // notificationTapDialog(title: event.data["title"],desc: event.data["body"],type: event.data["type"]);
      ///Handle tap here event.data["id"]
    });
    firebaseMessaging.requestPermission(sound: true, badge: true, alert: true, provisional: true);
    firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      print("FCM TOKEN----------> $token");
      setFCMToken(token: token ?? "");
      // AuthenticationController.authenticate.updateFirebaseToken();
      // if(getFCMToken() != token){
      //   if(getIsLogin()){
      //     AuthenticationController.authenticate.updateFirebaseToken();
      //   }
      // }
    });
  }

  static showNotification(PushNotificationModel data) async {
    if (kDebugMode) {
      print(data);
    }
    var android =
    const AndroidNotificationDetails(
        'channel id', 'channel NAME', priority: Priority.high,
        channelDescription: 'CHANNEL DESCRIPTION',
        importance: Importance.max);
    var iOS = const IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    var jsonData = jsonEncode(data);
    await flutterLocalNotificationsPlugin!.show(123, data.title, data.body, platform, payload: jsonData);
  }

}

class PushNotificationModel {
  PushNotificationModel({
    this.title,
    this.body,
    this.data
  });

  String? title;
  String? body;
  dynamic data;

  factory PushNotificationModel.fromJson(Map<String, dynamic> json) => PushNotificationModel(
    title: json["title"],
    body: json["body"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "body": body,
    "data": data
  };
}
