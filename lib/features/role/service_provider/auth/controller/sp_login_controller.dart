import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/auth/model/user_model.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SpLoginController extends GetxController {
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isSuccess = false;
  UserModel? _user;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;
  UserModel? get user => _user;

  // form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  var isPasswordVisible = true.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Controller for the text field
  TextEditingController categoryController = TextEditingController();

  // Dummy userId for new category (replace with actual userId)
  // String userId = "user123";

  var isFromValid = false.obs;
  void validateFrom() {
    isFromValid.value =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
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

  Future<bool> login() async {
    EasyLoading.show(status: 'Logging in...');
    _isLoading = true;
    update();

    Map<String, dynamic> requestBody = {
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
    };

    final response = await Get.find<SpNetworkCaller>().postRequest(
      Urls.login,
      requestBody,
    );

    if (response.isSuccess) {
      _isSuccess = true;
      _errorMessage = '';
      // print("Response: ${response.responseData}");
      // print("Response: ${response.responseData['data']}");

      _user = UserModel.fromJson(response.responseData['data']["user"]);
      EasyLoading.showSuccess(response.responseData['message']);
      // Get.offAll(() => BottomNavbar(), arguments: planName);
    } else {
      _isSuccess = false;
      _errorMessage = response.errorMessage;
      EasyLoading.showError(response.errorMessage);
    }
    EasyLoading.dismiss();
    _isLoading = false;
    update();
    return _isSuccess;
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  // Fetch categories from the API
}
