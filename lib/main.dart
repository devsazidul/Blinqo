import 'package:blinqo/app.dart';
import 'package:blinqo/core/services/notification_service.dart';
// import 'package:blinqo/core/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

// lib/features/role/event_planner/notification/utils/notification_service.dart
import 'core/utils/theme/custom_themes/text_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp();
  await NotificationService.instance.initialize();
  // Stripe.publishableKey = dotenv.get('STRIPE_PUBLISHABLE_KEY', fallback: '');
  Stripe.publishableKey =
      'pk_test_51RBy8VEUlVKujITuQoI2db1u5vXbjKmjhqE0qAELNL8SQXpNH8GLsSMJ5Wrk4uUgWGD0GJLOrQ8n7GEyShlr01DT00Qg41bjZB';
  Get.put(ThemeController());

  runApp(const Blinqo());
}
