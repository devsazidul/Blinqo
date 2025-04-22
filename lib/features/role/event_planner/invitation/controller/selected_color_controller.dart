import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedColorController extends GetxController {
  // Reactive variable to hold the selected color
  var selectedColor = Color(0xFFFF2D55).obs;
  // var selectedColor = Color.fromARGB(0, 74, 74, 14).obs;

  // Method to update the selected color
  void changeColor(Color color) {
    selectedColor.value = color;
  }
}
