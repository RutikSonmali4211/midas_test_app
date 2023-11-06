import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

// class DeviceTokenController {
//   static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


//   static Future<String?> getDeviceToken()async{
//     String? token = await _firebaseMessaging.getToken();
//     return token;
//   }

//   static void refreshDeviceToken() {
//     _firebaseMessaging.onTokenRefresh.listen((newToken) {
//     });
//   }
// }

class DeviceTokenController {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Request the FCM token with proper permission handling
  static Future<String?> getDeviceToken() async {
    if (Platform.isIOS) {
      final NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        return null;
      }
    }

    String? token = await _firebaseMessaging.getToken();
    return token;
  }

  // Listen for token refresh
  static void refreshDeviceToken() {
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      // Handle token refresh if needed
    });
  }
}
