import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reliable_hands/firebase_options.dart';

FlutterLocalNotificationsPlugin? localNotificationsPlugin;

class FirebaseMessagingManager {
  static final FirebaseMessagingManager manager = FirebaseMessagingManager._();

  factory FirebaseMessagingManager() => manager;

  FirebaseMessagingManager._();

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    ///Initialize
    await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      alert: true,
      carPlay: true,
      criticalAlert: true,
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      sound: true,
      alert: true,
      badge: true,
    );

    localNotificationsPlugin = FlutterLocalNotificationsPlugin();

    ///Adding drawable resource
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    localNotificationsPlugin!.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (str) {

          Map<String, dynamic> data  = json.decode(str.payload!);
          handleClick(data);
        });


    FirebaseMessaging.onMessage.listen((message) {
      _notificationsHandler(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) async {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (message != null) {

          debugPrint('background app');
          handleClick(message.data);
        }
      });
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (message != null) {

          debugPrint("background notification ${message.data.toString()}");

          handleClick(message.data);
        }
      });
    });
    getToken();
  }

  Future<String?> getToken() async {
    try{
      String? token = await FirebaseMessaging.instance.getToken();

      debugPrint("Firebase token $token");
      return token;
    }
    catch(e) {
      debugPrint(e.toString());
      return null;
    }
  }

  void handleClick(Map<String, dynamic> data) {
    debugPrint("*******************  handleClick called  *****************");
    debugPrint("*******************  data ${data.toString()}  *****************");
    debugPrint("*******************  data['object'] ${data['object']}  *****************");
  }

  Future<void> _notificationsHandler(RemoteMessage message) async {
    RemoteNotification notification =
        message.notification ?? const RemoteNotification();

    if (notification.title != null && notification.body != null) {
      _showNotificationWithDefaultSound(message);
    }
  }

  Future<void> _showNotificationWithDefaultSound(RemoteMessage message) async {
    RemoteNotification data =
        message.notification ?? const RemoteNotification();

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'title', 'Reliable Farmer',
        importance: Importance.max,
        playSound: true,
        styleInformation: BigTextStyleInformation(data.body ?? ''),
        priority: Priority.high);
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await localNotificationsPlugin?.show(
      1,
      data.title,
      data.body,
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
    );
  }
}
