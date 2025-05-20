import 'package:blinqo/features/role/event_planner/notification/screens/notification_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  // Singleton object
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  // static const String _fcmTokenKey = 'fcm-token';
  static String? fcmToken;

  final _messaging = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // request permission
    await _requestPermission();

    // setup message handler
    await _setupMessageHandlers();

    fcmToken = await _messaging.getToken();

    // debugPrint("FCM token: $token");
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );

    debugPrint('Permission status: ${settings.authorizationStatus}');
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }

    // android setup
    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'My high importance notifications',
      importance: Importance.high,
    );

    await _localNotification
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // ios setup
    final initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // flutter notification setup
    await _localNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        // Handle notification tap
        final payload = details.payload;
        // navigate to chat screen
        debugPrint(payload);
        Get.to(() => const NotificationScreen());
      },
    );

    _isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription: 'My high importance notifications',
            importance: Importance.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  Future<void> _setupMessageHandlers() async {
    // Foreground message
    FirebaseMessaging.onMessage.listen((message) {
      // ignore: avoid_print
      print(message.data);
      debugPrint(message.notification?.title);
      debugPrint(message.notification?.body);
      showNotification(message);
      // if (message.data['type'] == 'notification') {
      //   // open chat screen
      //   Get.to(NotificationScreen());
      // }
    });

    // Background message
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // opened app
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    // ignore: avoid_print
    print(message.data);
    debugPrint(message.notification?.title);
    debugPrint(message.notification?.body);
    if (message.data['type'] == 'chat') {
      // open chat screen
      (message.data);
    }
  }

  // save fcm token
  // static Future<void> saveFcmToken({String? token}) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   if (token != null) {
  //     sharedPreferences.setString(_fcmTokenKey, token);
  //     fcmToken = token;
  //   }
  // }
}
