import 'package:blinqo/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'core/utils/theme/custom_themes/text_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51RBy8VEUlVKujITuQoI2db1u5vXbjKmjhqE0qAELNL8SQXpNH8GLsSMJ5Wrk4uUgWGD0GJLOrQ8n7GEyShlr01DT00Qg41bjZB';
  Get.put(ThemeController());
  runApp(const Blinqo());
}
