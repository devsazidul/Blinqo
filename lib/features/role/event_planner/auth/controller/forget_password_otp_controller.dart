import 'dart:async';
import 'dart:convert';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/change_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FPOTPController extends GetxController {
  // OTP related controllers
  TextEditingController pinController = TextEditingController();

  // Track OTP form validity
  var isFormValid = false.obs;

  // Countdown timer related variables
  var resendEnabled = true.obs; // To control if the button is enabled
  var countdown = 120.obs; // Time in seconds for the countdown
  Timer? timer; // Timer instance

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

      Map<String, String> requestbody = {"email": '$email', "code": otp};

      final response = await http.post(
        Uri.parse(Urls.verifyResetCode),
        body: requestbody,
      );

      debugPrint('Response Body: ${response.body}');
      debugPrint("Status Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('OTP Verified Successfully, navigating...');
        EasyLoading.showSuccess('OTP Verified Successfully');
        pinController.clear();
        // Pass email and OTP to ChangePasswordScreen
        Get.to(() => ChangePasswordScreen(email: email, otp: otp));
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

      // Check if the response body is empty
      if (response.body.isEmpty) {
        debugPrint("Response body is empty.");
        EasyLoading.showError("Received an empty response. Please try again.");
        return; // Exit the function if the response is empty
      }

      // If the response body is not empty, parse it
      try {
        var responseData = jsonDecode(response.body);
        debugPrint("Parsed response data: $responseData");

        if (response.statusCode == 200 || response.statusCode == 201) {
          EasyLoading.showSuccess('OTP Sent Successfully');
          debugPrint('OTP Sent Successfully: ${response.body}');
          startCountdown();
        } else {
          var errorMessage = responseData['message'] ?? 'An error occurred';
          debugPrint("Error Message: $errorMessage");

          if (errorMessage.contains('Invalid or expired OTP')) {
            EasyLoading.showError("Invalid or expired OTP. Please try again.");
          } else {
            EasyLoading.showError(errorMessage);
          }
        }
      } catch (e) {
        debugPrint("Error decoding response: $e");
        EasyLoading.showError("Error decoding response. Please try again.");
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong: $e");
      debugPrint("Error occurred: $e");
    } finally {
      EasyLoading.dismiss();
      debugPrint("OTP process finished.");
    }
  }

  // Start the countdown when the OTP is sent
  void startCountdown() {
    resendEnabled.value = false; // Disable the button
    countdown.value = 120; // Reset the countdown to 120 seconds

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        resendEnabled.value = true; // Enable the button after the countdown
        timer.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  @override
  void onClose() {
    timer?.cancel(); // Cancel the timer when the controller is disposed
    super.onClose();
  }
}
