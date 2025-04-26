import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class EpPaymentOptionController extends GetxController {
  var isPaymentMethodAdded = false.obs;
  RxList<bool> selectedCards = <bool>[].obs;

  void toggleCardSelection(int index) {
    selectedCards[index] = !selectedCards[index];
    update();
  }

  void initializeSelectedCards(int numberOfCards) {
    selectedCards = List.generate(numberOfCards, (index) => false).obs;
    update();
  }

  void togglePaymentMethod() {
    isPaymentMethodAdded.value = !isPaymentMethodAdded.value;
  }

  // Stripe payment logic

  Map? paymentIntent;

  Future makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('10', 'USD');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          googlePay: const PaymentSheetGooglePay(
            testEnv: true,
            currencyCode: "USD",
            merchantCountryCode: "US",
          ),
          merchantDisplayName: 'shakil',
        ),
      );

      displayPaymentSheet();
    } catch (e) {
      debugPrint("Exception: $e");
      if (e is StripeConfigException) {
        debugPrint("Stripe exception: ${e.message}");
      } else {
        debugPrint("Exception: $e");
      }
    }
  }

  // Function to create a payment intent with the specified amount and currency
  Future<Map<String, dynamic>> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Map body = {
        'amount': ((int.parse(amount)) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var secretKey =
          "sk_test_51RBy8VEUlVKujITusgjKVRvLqAfznM2fbBPJsIiH2mvDTgOGqMynVFzNdqdYklpIjgLsYQTFyeUuDttOdP2NGbe300ZL3PqajL";

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body.toString());
      } else {
        debugPrint('Failed to create payment intent: ${response.body}');
        throw Exception('Failed to create payment intent');
      }
    } catch (err) {
      debugPrint('Error charging user: ${err.toString()}');
      rethrow;
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      Get.showSnackbar(
        GetSnackBar(
          title: "Paid Successfully",
          message: "your Payment was Processed",
          duration: Duration(seconds: 2),
        ),
      );
      isPaymentMethodAdded.value = true;
      paymentIntent = null;
    } on StripeException catch (e) {
      debugPrint('Error: $e');
      Get.showSnackbar(
        GetSnackBar(
          title: "Payment Not Selected",
          message: "Payment ",
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      debugPrint("Error in displaying payment sheet: $e");
    }
  }
}
