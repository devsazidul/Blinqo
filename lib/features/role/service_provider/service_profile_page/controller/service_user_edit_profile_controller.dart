import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceUserEditProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  // final TextEditingController cityController = TextEditingController();

  // Observable variable to hold the text
  var name = 'is null'.obs;
  // var email = ''.obs;
  // var phone = ''.obs;
  // var address = ''.obs;
  // var city = ''.obs;

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(() {
      name.value = nameController.text;
    });
    // email.value = emailController.text;
    // phone.value = phoneController.text;
    // address.value = addressController.text;
    // city.value = cityController.text;
  }

  @override
  void onClose() {
    nameController.dispose();
    // emailController.dispose();
    // phoneController.dispose();
    // addressController.dispose();
    // cityController.dispose();
    super.onClose();
  }
}
