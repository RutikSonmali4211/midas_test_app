import 'dart:convert';

import 'package:flutter/material.dart'; // Import the material package for Flutter
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/screen/notifications/notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  // ignore: unnecessary_null_comparison
  if (message == null) return;
  print(message.notification?.title);
  print(message.notification?.body);
}

class FirebaseApi {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  late AndroidNotificationChannel channel;

  bool isFlutterLocalNotificationsInitialized = false;

  final _firebaseMessaging = FirebaseMessaging.instance;

  handleMessage(RemoteMessage? message) {
    if (message == null) return;
    print(message.notification?.title);
  }

  Future<void> initLocalNotification() async {
    final InitializationSettings initializationSettings =
        // ignore: prefer_const_constructors
        InitializationSettings(
            android:
                const AndroidInitializationSettings("@drawable/ic_launcher"));

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        print("fev ${notificationResponse.payload}");
      },
    );
  }

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  initPushNotification() {
    _firebaseMessaging.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
  }

  void showFlutterNotification(RemoteMessage message) {
    ConstantUtil.isNotificationReceived.value =true;
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      String payload = message.data['payload'] ?? '';
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        payload: jsonEncode(message.toMap()),
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: '@drawable/ic_launcher',
          ),
        ),
      );

      if (payload.isNotEmpty) {
        navigateToScreen(payload);
      }
    }
  }

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateToScreen(String payload) {
    // Map<String, dynamic> data = jsonDecode(payload);
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => const Notifications()),
    );
  }

  initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print('Token : $fcmToken ');
    await setupFlutterNotifications();
    initLocalNotification();

    initPushNotification();
  }
}
