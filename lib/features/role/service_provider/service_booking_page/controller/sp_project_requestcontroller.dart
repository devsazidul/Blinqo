import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpProjectRequestcontroller extends GetxController {
  RxString enteredText = ''.obs;
  RxBool isEditable = true.obs;
  RxBool isAcceptClicked = false.obs;
  TextEditingController psetpricecontroller = TextEditingController();

  void onAcceptTapped() {
    isAcceptClicked.value = true;
    isEditable.value = true;
  }

  void onSubmitTapped(String text) {
    enteredText.value = text;
    psetpricecontroller.text = text;
    isEditable.value = false;
    // isAcceptClicked.value = false;
  }

  void onDeclineTapped() {
    isAcceptClicked.value = false;
    isEditable.value = true;
  }
}
