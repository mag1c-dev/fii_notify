import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseService {
  static Future<void> _registerNotifyToken({required String empNo}) async {
    final token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection('UserTokens')
        .doc(empNo)
        .set({'token': token});
  }


  static  Future<void> registerNotify({required String empNo}) async {
    await _registerNotifyToken(empNo: empNo);

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    void onDidReceiveNotificationResponse(NotificationResponse details) {
    }

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
    NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
        String? title = remoteMessage.notification?.title;
        String? body = remoteMessage.notification?.body;

        var androidDetails = const AndroidNotificationDetails(
          "fiisw.notify-service",
          "SmartFactory Notification",
          channelDescription: "Notify from Smart factory eco-system",
          importance: Importance.high,
          priority: Priority.high,
        );
        var darwinDetails = const DarwinNotificationDetails();
        var platformDetails =
        NotificationDetails(android: androidDetails, iOS: darwinDetails, );
        await flutterLocalNotificationsPlugin.show(
            0, title, body, platformDetails);
      });
    }
  }
}