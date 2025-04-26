import 'package:firebase_messaging/firebase_messaging.dart';

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
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User denied permission');
    }
  }

  Future<void> getDeviceToken() async {
    String? token = await messaging.getToken();
    print("Device token: $token");
    // return token!;
  }

  Future<void> isTokenRefresh() async {
    await messaging.onTokenRefresh.listen((token) {
      print("Refreshed token: $token");
      token.toString();
    });
    // return token!;
  }
}
