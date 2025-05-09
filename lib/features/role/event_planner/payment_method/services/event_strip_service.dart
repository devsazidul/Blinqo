import 'package:blinqo/features/role/venue_owner/payment_page/public_private_key/public_private_stripe_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';

import '../screen/evetnt_congratulation_screen.dart';

class EventStripService {
  // Create a logger instance for debugging
  final logger = Logger(printer: PrettyPrinter());

  // Private constructor for singleton
  EventStripService._();
  static final EventStripService instance = EventStripService._();

  Future<void> makePayment(BuildContext context) async {
    try {
      // Step 1: Create Payment Intent
      String? paymentClientSecret = await _createPaymentIntent(100, "USD");
      if (paymentClientSecret == null) {
        Get.snackbar(
          'Error',
          'Failed to create payment intent',
          snackPosition: SnackPosition.BOTTOM,
        );
        logger.e("Failed to create payment intent");
        return;
      }

      // Step 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentClientSecret,
          merchantDisplayName: "Md Razib",
        ),
      );

      // Step 3: Process Payment
      await _processPayment();

      // Step 4: Navigate to ThankYouPage on success using GetX
      logger.i("Payment successful");
      // Get.to(
      //   () => const EventCongratulationScreen(),
      //   transition: Transition.rightToLeft,
      //   duration: const Duration(milliseconds: 500),
      // );
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, EventCongratulationScreen.routeName);
    } catch (e) {
      // Show snackbar on failure using GetX
      Get.snackbar(
        'Error',
        'Payment failed ',
        snackPosition: SnackPosition.BOTTOM,
      );
      logger.e("Error making payment: $e");
    }
  }

  /// Creates a Payment Intent by calling Stripe's API using http package.
  /// Returns the client secret or null if the request fails.
  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization": "Bearer $stripeSecretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {'amount': _calculateAmount(amount), 'currency': currency},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        logger.i("Payment Intent created: ${data['client_secret']}");
        return data["client_secret"];
      } else {
        logger.e("Failed to create Payment Intent: ${response.body}");
        return null;
      }
    } catch (e) {
      logger.e("Error creating payment intent: $e");
      return null;
    }
  }

  /// Presents the Payment Sheet to process the payment.
  Future<void> _processPayment() async {
    try {
      // Show the Payment Sheet (handles confirmation automatically)
      await Stripe.instance.presentPaymentSheet();
      logger.i("Payment Sheet presented successfully");
    } catch (e) {
      logger.e("Error processing payment: $e");
      rethrow; // Re-throw to handle in makePayment
    }
  }

  /// Converts amount to cents for Stripe (e.g., 99999 -> 9999900).
  String _calculateAmount(int amount) {
    final calculateAmount = amount * 100;
    return calculateAmount.toString();
  }
}
