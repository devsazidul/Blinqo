import 'package:blinqo/core/common/widgets/logger_view.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/screens/v_congratulation_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../public_private_key/public_private_stripe_key.dart';

class VStripeServices {

  final logger = createLogger();

  // Private constructor for singleton
  VStripeServices._();
  static final VStripeServices instance = VStripeServices._();

  /// Initiates a payment of $10 USD.
  /// Navigates to ThankYouPage on success using GetX, shows snackbar on failure.
  Future<void> makePayment() async {
    try {
      // Step 1: Create Payment Intent
      String? paymentClientSecret = await _createPaymentIntent(10, "USD");
      if (paymentClientSecret == null) {
        EasyLoading.showError('Failed to create payment intent');
        logger.e("Failed to create payment intent");
        return;
      }


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
      Get.to(
        () => const VCongratulationScreen(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 500),
      );
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
