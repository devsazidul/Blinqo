import 'dart:convert';

import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OTPController extends GetxController {
  // OTP related controllers
  TextEditingController pinController = TextEditingController();

  // Track OTP form validity
  var isFormValid = false.obs;

  // Validate if the OTP form is filled correctly
  void validateForm() {
    isFormValid.value = pinController.text.length == 6;
  }

  var errorColor = false.obs;

  void validatePin(String? email) async {
    debugPrint("Parsing email: $email");

    try {
      EasyLoading.show(status: 'Verifying OTP...');

      String otp = pinController.text.trim();
      debugPrint("User input OTP: $otp");

      // Check if OTP is empty or invalid
      if (otp.isEmpty) {
        EasyLoading.showError("Please enter a valid OTP.");
        return;
      }

      Map<String, String> requestbody = {"identifier": '$email', "code": otp};

      final response = await http.post(
        Uri.parse(Urls.verifyEmail),
        // headers: {"Authorization": 'Bearer $accessToken'},  // Ensure proper bearer token format
        body: requestbody,
      );

      debugPrint('Response Body: ${response.body}');
      debugPrint("Status Code: ${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint('OTP Verified Successfully, navigating...');
        EasyLoading.showSuccess('OTP Verified Successfully');
        Get.to(() => LogInScreen());
      } else {
        debugPrint("Failed with status code: ${response.statusCode}");
        var responseData = jsonDecode(response.body);
        var errorMessage = responseData['message'] ?? 'An error occurred';
        if (errorMessage.contains('Invalid or expired OTP')) {
          errorColor.value = true;
          EasyLoading.showError("Invalid or expired OTP. Please try again.");
        } else {
          EasyLoading.showError(errorMessage);
        }
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  void resendCode(String? email) async {
    debugPrint("Parsing email: $email");

    try {
      EasyLoading.show(status: 'Sending OTP...');
      debugPrint("Preparing request body with email: $email");
      Map<String, String> requestbody = {"email": '$email'};
      debugPrint("Request body: $requestbody");

      final response = await http.post(
        Uri.parse(Urls.resendVerificationCode),
        body: requestbody,
      );

      debugPrint("Response received.");
      debugPrint("Response Body: ${response.body}");
      debugPrint("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('OTP Sent Successfully');
        debugPrint('OTP Sent Successfully: ${response.body}');
      } else {
        if (response.body.isEmpty) {
          debugPrint("Response body is empty.");
          EasyLoading.showError(
            "Received an empty response. Please try again.",
          );
        } else {
          try {
            var responseData = jsonDecode(response.body);
            var errorMessage = responseData['message'] ?? 'An error occurred';
            debugPrint("Error Message: $errorMessage");

            if (errorMessage.contains('Invalid or expired OTP')) {
              EasyLoading.showError(
                "Invalid or expired OTP. Please try again.",
              );
            } else {
              EasyLoading.showError(errorMessage);
            }
          } catch (e) {
            debugPrint("Error decoding response: $e");
            EasyLoading.showError("Error decoding response. Please try again.");
          }
        }
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong: $e");
      debugPrint("Error occurred: $e");
    } finally {
      EasyLoading.dismiss();
      debugPrint("OTP process finished.");
    }
  }
}
