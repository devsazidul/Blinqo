import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpEditProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final fastNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();

  // Observable variables
  final RxString fastName = ''.obs;
  final RxString lastName = ''.obs;
  final RxString email = ''.obs;
  final RxString country = ''.obs;
  final RxString city = ''.obs;

  @override
  void onInit() {
    super.onInit();
    setupListeners();
    initializeValues();
  }

  void setupListeners() {
    fastNameController.addListener(
      () => fastName.value = fastNameController.text,
    );
    lastNameController.addListener(
      () => lastName.value = lastNameController.text,
    );
    emailController.addListener(() => email.value = emailController.text);
    countryController.addListener(() => country.value = countryController.text);
    cityController.addListener(() => city.value = cityController.text);
  }

  void initializeValues() {
    fastName.value = fastNameController.text;
    lastName.value = lastNameController.text;
    email.value = emailController.text;
    country.value = countryController.text;
    city.value = cityController.text;
  }

  // Validation methods
  String? validateFastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First name is required';
    }
    if (value.length < 2) {
      return 'First name must be at least 2 characters';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last name is required';
    }
    if (value.length < 2) {
      return 'Last name must be at least 2 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validateCountry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Country is required';
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    }
    return null;
  }

  bool validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return false;
    }
    formKey.currentState?.save();
    return true;
  }

  void saveForm() {
    if (validateForm()) {
      // Here you would typically save the data to your backend
      Get.snackbar('Success', 'Profile updated successfully');

      // Update the observable values
      fastName.value = fastNameController.text = "";
      lastName.value = lastNameController.text = "";
      email.value = emailController.text = "";
      country.value = countryController.text = "";
      city.value = cityController.text = "";
    }
  }

  @override
  void onClose() {
    fastNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    countryController.dispose();
    cityController.dispose();
    super.onClose();
  }
}
