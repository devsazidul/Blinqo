import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpLoginController extends GetxController {
  TextEditingController passwordControler = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var isPasswordVisible = true.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Controller for the text field
  TextEditingController categoryController = TextEditingController();

  // Dummy userId for new category (replace with actual userId)
  String userId = "user123";

  var isFromValid = false.obs;
  void validateFrom() {
    isFromValid.value =
        emailController.text.isNotEmpty && passwordControler.text.isNotEmpty;
  }

  // Password validation method
  // String? validatePassword(String value) {
  //   if (value.isEmpty) {
  //     return 'Password is required';
  //   }
  //   if (value.length < 8) {
  //     return 'Password must be at least 8 characters';
  //   }
  //   if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value)) {
  //     return 'Password must contain at least one letter and one number';
  //   }
  //   return null;
  // }
  // Future<void> login() async {
  //   EasyLoading.show(status: 'Logging in...');
  //   try {
  //     Map<String, dynamic> requestBody = {
  //       'email': emailController.text.trim(),
  //       'password': passwordControler.text.trim(),
  //     };
  //     final response = await http.post(
  //       Uri.parse(Urls.login),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(requestBody),
  //     );
  //     debugPrint("================1${response.body}");
  //     debugPrint("===============${response.statusCode}");
  //     final responseData = jsonDecode(response.body);
  //     if (response.statusCode == 200 && responseData["accessToken"] != null) {
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       await prefs.setString('accessToken', responseData["accessToken"]);
  //       EasyLoading.showSuccess("Login Successful");
  //       String planName = prefs.getString('planName') ?? "Basic";
  //       Get.offAll(() => BottomNavbar(), arguments: planName);
  //     } else {
  //       EasyLoading.showError(responseData["message"] ?? "Login Failed");
  //     }
  //   } catch (e) {
  //     EasyLoading.showError("An error occurred");
  //     debugPrint("Login Error: $e");
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }

  void clearFields() {
    emailController.clear();
    passwordControler.clear();
  }

  // Fetch categories from the API
}
