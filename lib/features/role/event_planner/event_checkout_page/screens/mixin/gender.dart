import 'package:get/get.dart';

mixin GenderMixin {
  var selectedGender = "Male".obs; // Default to Male
  var genders = ["Male", "Female"];

  void updateGender(String newGender) {
    selectedGender.value = newGender;
  }
}
