import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/rendering.dart';

class FirebaseNotificationService {
  FirebaseNotificationService._();

  static final FirebaseNotificationService instance =
      FirebaseNotificationService._();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User denied permission');
    }
  }

  Future<void> getDeviceToken() async {
    String? token = await messaging.getToken();
    debugPrint("Device token: $token");
    // return token!;
  }

  Future<void> isTokenRefresh() async {
    messaging.onTokenRefresh.listen((token) {
      debugPrint("Refreshed token: $token");
      token.toString();
    });
    // return token!;
  }
}
