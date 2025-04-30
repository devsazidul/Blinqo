import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickColorController extends GetxController {
  // Reactive variable to hold the selected color
  final List<Color> colorList = [
    Color(0xFF003366),
    Color(0xFFD4AE37),
    Color(0xFFFF2D55),
    Color(0xFF34C759),
    Color(0xFFFF3B30),
    Color(0xFF007AFF),
    Color(0xFFAE52DE),
    Color(0xFFFF9500),
    Color(0xFF00C7BE),
    Color(0xFFA2845D),
  ];

  Color _selectColor = Color(0xFFFF2D55);
  Color _selectedColor = Color(0xFFFF2D55);
  final Rx<bool> _isFemale = true.obs;

  Color get selectColor => _selectColor;
  Color get selectedColor => _selectedColor;
  Rx<bool> get isFemale => _isFemale;

  // Method to update the selected color
  void selectAColor(Color color) {
    _selectColor = color;
    update();
  }

  void changeColor(var color) {
    _selectedColor = color;
    update();
  }
}
