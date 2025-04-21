import 'package:get/get.dart';

class SearchDetailsController extends GetxController {
  var selectedCity = "City".obs;
  var city = ["City", "New Work", "London", "Canada"];

  void updateSelectedCity(String value) {
    selectedCity.value = value;
  }

  var selectedArea = "Area".obs;
  var area = ["Area", "Japan", "France", "Australia"];

  void updateSelectedArea(String value) {
    selectedArea.value = value;
  }
}
