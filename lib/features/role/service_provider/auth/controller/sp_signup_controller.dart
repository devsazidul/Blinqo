import 'dart:convert';

import 'package:blinqo/core/models/response_data.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SpSignupController extends GetxController {
  // Declare the controllers for text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController1 = TextEditingController();
  TextEditingController emailController1 = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypepasswordController = TextEditingController();
  // TextEditingController pinController = TextEditingController();

  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  var isPasswordVisible1 = false.obs;
  void togglePasswordVisibility1() {
    isPasswordVisible1.value = !isPasswordVisible1.value;
  }

  var isFromValid = false.obs;
  void validateFrom() {
    isFromValid.value =
        nameController.text.isNotEmpty &&
        phoneController1.text.isNotEmpty &&
        emailController1.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        retypepasswordController.text.isNotEmpty;
  }

  // var isFormValid2 = false.obs;
  // void validdateForm2() {
  //   isFormValid2.value = pinController.text.length == 6;
  // }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }

  // Properly dispose of controllers when the controller is disposed
  Future<void> signup() async {
    EasyLoading.show(status: "Signing up....");

    try {
      // Validate fields to ensure they're not empty
      if (emailController1.text.trim().isEmpty ||
          passwordController.text.trim().isEmpty ||
          nameController.text.trim().isEmpty ||
          phoneController1.text.trim().isEmpty) {
        EasyLoading.showError("All fields are required.");
        return;
      }

      // Construct the request body
      Map<String, dynamic> requestBody = {
        "email": emailController1.text.trim(),
        "password": passwordController.text.trim(),
        "name": nameController.text.trim(),
        "phone": phoneController1.text.trim(),
        "roles": ["SERVICE_PROVIDER"], // Replace this with a valid role
      };

      final uri = Uri.parse(Urls.register);
      print("Requesting URL: $uri");

      // Make the HTTP POST request
      final response = await http.post(
        uri,
        headers: {"Content-Type": "Application/json"},
        body: jsonEncode(requestBody),
      );

      // Check if the response status is 201 (Created)
      if (response.statusCode == 201) {
        EasyLoading.showSuccess("Registration Successful");
        print("Response Body: ${response.body}");

        // Decode the response body
        final responseData = jsonDecode(response.body);

        // Log the response data for debugging
        print("Decoded Response: $responseData");

        // Extract the access token from the response and save it to SharedPreferences
        String accessToken = responseData["data"]["access_token"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);

        // Optionally, you could navigate the user to another screen or show a success message
        // For example: Get.toNamed(AppRoute.otpSendScreen);

        // Here, you can also handle email verification or prompt the user to check their email
        EasyLoading.showInfo(
          "A verification code has been sent to your email. Please verify.",
        );
      } else {
        final responseData = jsonDecode(response.body);
        print("Error Response Body: ${response.body}");
        EasyLoading.showError(responseData["message"]);
      }
    } catch (e) {
      print("Error occurred: $e");
      EasyLoading.showError("Error Occurred");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
