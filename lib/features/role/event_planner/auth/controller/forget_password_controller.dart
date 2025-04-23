import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final ValueNotifier<int> focusedButtonIndex = ValueNotifier<int>(0);

  var isLoading = false.obs;

  var isFormValid2 = false.obs;
}
