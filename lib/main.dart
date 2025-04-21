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


/* 
           Center(
                    child: Text(
                      'Availability',
                      style: getTextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: const Color(0xff333333),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),


                  
                  Container     (
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomCalendar(
                      selectedDatesNotifier: selectedDatesNotifier,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      StatusLabel(
                        color: Color(0xff0066CC),
                        label: 'Booked',
                      ),
                      SizedBox(height: 8),
                      StatusLabel(
                        color: Color(0xff19480B),
                        label: 'Selected',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                
                
                

*/