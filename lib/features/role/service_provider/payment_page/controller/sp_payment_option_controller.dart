import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_verification_thanks.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SpPaymentOptionController extends GetxController {
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

  Map<dynamic, dynamic>? paymentIntent;

  Future<void> payWithStripe({required double amount}) async {
    Map<String, dynamic> requestBody = {
      "currency": "usd",
      "email": SpAuthController.spUser?.email,
      "amount": amount,
      // "id": SpAuthController.spUser?.profile?.id,
      "userId": SpAuthController.spUser?.profile?.id,
      "paymentType": "verificationFee",
    };

    final response = await Get.find<SpNetworkCaller>().postRequest(
      Urls.createPaymentIntent,
      requestBody,
    );

    if (response.isSuccess) {
      final String clientSecret = response.responseData['data']['clientSecret'];
      Logger().i(response.responseData['data']['clientSecret']);
      // final paymentMethod = await Stripe.instance.createPaymentMethod(
      //   params: PaymentMethodParams.card(
      //     paymentMethodData: PaymentMethodData(
      //       billingDetails: BillingDetails(
      //         email: SpAuthController.spUser?.email,
      //         name: SpAuthController.spUser?.name,
      //       ),
      //     ),
      //   ),
      // );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: SpAuthController.spUser?.name,
        ),
      );
      await displayPaymentSheet();
    } else {
      EasyLoading.showError(response.responseData['message']);
      EasyLoading.dismiss();
      // Get.showSnackbar(GetSnackBar(title: "Payment Failed"));
    }
  }

  // Future<void> makePayment({
  //   required String amount,
  //   String currency = 'USD',
  // }) async {
  //   try {
  //     paymentIntent = await createPaymentIntent(amount, currency);

  //     // Initialize the payment sheet
  //     await Stripe.instance.initPaymentSheet(
  //       paymentSheetParameters: SetupPaymentSheetParameters(
  //         paymentIntentClientSecret: paymentIntent!['client_secret'],
  //         googlePay: const PaymentSheetGooglePay(
  //           testEnv: true,
  //           currencyCode: "USD",
  //           merchantCountryCode: "US",
  //         ),
  //         merchantDisplayName: 'Test Merchant',
  //       ),
  //     );

  //     displayPaymentSheet();
  //   } catch (e) {
  //     debugPrint("Exception: $e");
  //     if (e is StripeConfigException) {
  //       debugPrint("Stripe exception: ${e.message}");
  //     } else {
  //       debugPrint("Exception: $e");
  //     }
  //   }
  // }

  // // Function to create a payment intent with the specified amount and currency
  // Future<Map<String, dynamic>> createPaymentIntent(
  //   String amount,
  //   String currency,
  // ) async {
  //   try {
  //     Map body = {
  //       'amount': ((int.parse(amount)) * 100).toString(),
  //       'currency': currency,
  //       'payment_method_types[]': 'card',
  //     };

  //     var secretKey =
  //         "sk_test_51RBy8VEUlVKujITusgjKVRvLqAfznM2fbBPJsIiH2mvDTgOGqMynVFzNdqdYklpIjgLsYQTFyeUuDttOdP2NGbe300ZL3PqajL";

  //     var response = await http.post(
  //       Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //       headers: {
  //         'Authorization': 'Bearer $secretKey',
  //         'Content-Type': 'application/x-www-form-urlencoded',
  //       },
  //       body: body,
  //     );

  //     if (response.statusCode == 200) {
  //       return jsonDecode(response.body.toString());
  //     } else {
  //       debugPrint('Failed to create payment intent: ${response.body}');
  //       throw Exception('Failed to create payment intent');
  //     }
  //   } catch (err) {
  //     debugPrint('Error charging user: ${err.toString()}');
  //     rethrow;
  //   }
  // }
  Future<void> displayPaymentSheet() async {
    try {
      final result = await Stripe.instance.presentPaymentSheet();
      Logger().i("Payment Result: $result");

      Get.snackbar("Success", "Payment completed successfully!");
      isPaymentMethodAdded.value = true;
      Get.to(() => SpVerificationThanks());
    } on StripeException catch (e) {
      Logger().e("Stripe Exception: ${e.error.message}");
      Get.showSnackbar(
        GetSnackBar(
          title: "Payment Failed",
          message: e.error.message ?? "An unexpected error occurred.",
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      Logger().e("Unknown Error: $e");
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: "Something went wrong.",
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
  // Future<void> displayPaymentSheet() async {
  //   try {
  //     final response = await Stripe.instance.presentPaymentSheet();
  //     Logger().i('Payment Successful!');
  //     Logger().i('Payment Details: $response');

  //     isPaymentMethodAdded.value = true;
  //     paymentIntent = null;
  //   } on StripeException catch (e) {
  //     debugPrint('Error: $e');
  //     Get.showSnackbar(
  //       GetSnackBar(
  //         title: "Payment Not Selected",
  //         message: "Please select a payment method to proceed",
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //   } catch (e) {
  //     debugPrint("Error in displaying payment sheet: $e");
  //   }
  // }
}
