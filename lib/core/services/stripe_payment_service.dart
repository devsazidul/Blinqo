import 'package:blinqo/core/services/network_caller.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// export enum PaymentType {
//   BOOKING = 'booking',
//   FULL_PAYMENT = 'fullPayment',
//   VERIFICATION_FEE = 'verificationFee',
// }

enum PaymentType { booking, fullPayment, verificationFee }

extension PaymentTypeExtension on PaymentType {
  String get value {
    switch (this) {
      case PaymentType.booking:
        return 'booking';
      case PaymentType.fullPayment:
        return 'fullPayment';
      case PaymentType.verificationFee:
        return 'verificationFee';
    }
  }
}

class PaymentService {
  String? currency;
  String? email;
  double? amount;
  String? id;
  String? userId;
  PaymentType? paymentType;

  PaymentService({
    this.currency,
    this.email,
    this.amount,
    this.id,
    this.userId,
    this.paymentType,
  });
}

class StripePaymentService {
  // singleton instance
  static final StripePaymentService _instance =
      StripePaymentService._internal();
  factory StripePaymentService() => _instance;
  StripePaymentService._internal();

  static Future<bool> payWithStripe({
    required PaymentService body,
    required String merchantDisplayName,
  }) async {
    bool isSuccess = false;

    try {
      final response = await Get.find<NetworkCaller>()
          .postRequest(Urls.createPaymentIntent, {
            "currency": body.currency,
            "email": body.email,
            "amount": body.amount,
            "id": body.id,
            "userId": body.userId,
            "paymentType": body.paymentType?.value,
          });

      if (response.isSuccess) {
        final String clientSecret =
            response.responseData['data']['clientSecret'];

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: merchantDisplayName,
          ),
        );
        await displayPaymentSheet();
        isSuccess = true;
      } else {
        EasyLoading.showError(response.responseData['message']);
        EasyLoading.dismiss();
      }
    } catch (e) {
      Logger().e("Unknown Error: $e");
      EasyLoading.showError("Something went wrong.");
    }
    return isSuccess;
  }

  static Future<void> displayPaymentSheet() async {
    try {
      final result = await Stripe.instance.presentPaymentSheet();
      Logger().i("Payment Result: $result");

      EasyLoading.showSuccess("Payment completed successfully!");
    } on StripeException catch (e) {
      Logger().e("Stripe Exception: ${e.error.message}");
      EasyLoading.showError(e.error.message ?? "An unexpected error occurred.");
    } catch (e) {
      Logger().e("Unknown Error: $e");
      EasyLoading.showError("Something went wrong.");
    }
  }
}
