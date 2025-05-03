import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SpSignupController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController1 = TextEditingController();
  TextEditingController emailController1 = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';
  bool _isSuccess = false;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;

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
    RegExp phoneRegex = RegExp(r'^\+8801[3-9][0-9]{8}$');
    RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    isFromValid.value =
        nameController.text.isNotEmpty &&
        phoneController1.text.isNotEmpty &&
        phoneRegex.hasMatch(phoneController1.text) &&
        emailController1.text.isNotEmpty &&
        emailRegex.hasMatch(emailController1.text) &&
        passwordController.text.isNotEmpty &&
        passwordController.text.length >= 8 &&
        retypePasswordController.text.isNotEmpty &&
        passwordController.text == retypePasswordController.text;
  }

  Future<bool> signUp() async {
    EasyLoading.show(status: "Signing up....");
    _isLoading = true;
    update();

    // request body
    Map<String, dynamic> requestBody = {
      "email": emailController1.text.trim(),
      "password": passwordController.text.trim(),
      "name": nameController.text.trim(),
      "phone": phoneController1.text.trim(),
      "roles": ["SERVICE_PROVIDER"], // Replace this with a valid role
    };

    final response = await Get.find<SpNetworkCaller>().postRequest(
      Urls.register,
      requestBody,
    );

    if (response.isSuccess) {
      // // save access token to shared preferences
      // String accessToken = response.responseData["data"]["access_token"];
      // Get.find<SpAuthController>().saveAccessToken(accessToken);
      EasyLoading.showSuccess(
        "A verification code has been sent to your email. Please verify.",
      );
      _isLoading = false;
      update();
      return true;
    } else {
      EasyLoading.showError(response.errorMessage);
      _isLoading = false;
      update();
      return false;
    }
  }

  // Future<void> signup() async {
  //   EasyLoading.show(status: "Signing up....");
  //   _isLoading = true;
  //   update();

  //   try {
  //     // Validate fields to ensure they're not empty
  //     if (emailController1.text.trim().isEmpty ||
  //         passwordController.text.trim().isEmpty ||
  //         nameController.text.trim().isEmpty ||
  //         phoneController1.text.trim().isEmpty) {
  //       EasyLoading.showError("All fields are required.");
  //       return;
  //     }

  //     // Construct the request body
  //     Map<String, dynamic> requestBody = {
  //       "email": emailController1.text.trim(),
  //       "password": passwordController.text.trim(),
  //       "name": nameController.text.trim(),
  //       "phone": phoneController1.text.trim(),
  //       "roles": ["SERVICE_PROVIDER"], // Replace this with a valid role
  //     };

  //     final uri = Uri.parse(Urls.register);
  //     print("Requesting URL: $uri");

  //     // Make the HTTP POST request
  //     final response = await http.post(
  //       uri,
  //       headers: {"Content-Type": "Application/json"},
  //       body: jsonEncode(requestBody),
  //     );

  //     // Check if the response status is 201 (Created)
  //     if (response.statusCode == 201) {
  //       EasyLoading.showSuccess("Registration Successful");
  //       print("Response Body: ${response.body}");

  //       // Decode the response body
  //       final responseData = jsonDecode(response.body);

  //       // Log the response data for debugging
  //       print("Decoded Response: $responseData");

  //       // Extract the access token from the response and save it to SharedPreferences
  //       String accessToken = responseData["data"]["access_token"];
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       await prefs.setString('accessToken', accessToken);

  //       // Optionally, you could navigate the user to another screen or show a success message
  //       // For example: Get.toNamed(AppRoute.otpSendScreen);

  //       // Here, you can also handle email verification or prompt the user to check their email
  //       EasyLoading.showInfo(
  //         "A verification code has been sent to your email. Please verify.",
  //       );
  //     } else {
  //       final responseData = jsonDecode(response.body);
  //       print("Error Response Body: ${response.body}");
  //       EasyLoading.showError(responseData["message"]);
  //     }
  //   } catch (e) {
  //     print("Error occurred: $e");
  //     EasyLoading.showError("Error Occurred");
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }

  @override
  void onClose() {
    nameController.dispose();
    phoneController1.dispose();
    emailController1.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    super.onClose();
  }
}
