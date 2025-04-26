import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchDetailsController extends GetxController {
  RxString selectedCity = "City".obs;
  List<String> city = ["City", "New York", "London", "Canada"];
  void updateSelectedCity(String value) {
    selectedCity.value = value;
  }

  RxString selectedArea = "Area".obs;
  List<String> area = ["Area", "Japan", "France", "Australia"];
  void updateSelectedArea(String value) {
    selectedArea.value = value;
  }

  RxString selectedVenue = "Birthday Party".obs;
  List<String> venueType = [
    "Birthday Party",
    "Wedding",
    "Corporate Event",
    "Bachelor Party",
    "Anniversary",
    "Others",
  ];

  void updateVenue(String value) {
    selectedVenue.value = value;
  }

  var capacityStart = 0.0.obs;
  void capacityStartValue(double value) {
    capacityStart.value = value;
  }

  var capacityEnd = 1000.0.obs;
  void capacityEndValue(double value) {
    capacityEnd.value = value;
  }

  RxInt selectedBookingValue = 0.obs;
  void toggleBooking() {
    selectedBookingValue.value = (selectedBookingValue.value == 0) ? 1 : 0;
  }

  RxDouble priceStart = 0.0.obs;
  void priceRangeStart(double value) {
    priceStart.value = value;
  }

  var priceEnd = 12000.0.obs;
  void priceRangeEnd(double value) {
    priceEnd.value = value;
  }

  var sliderValue = 0.0.obs;
  var ratingValue = 0.0.obs;

  void updateSliderValue(double value) {
    sliderValue.value = value;
    updateRatingValue(value);
  }

  void updateRatingValue(double value) {
    double newRating = (value / 10).roundToDouble() * 0.5;
    ratingValue.value = newRating.clamp(0.5, 5.0);
    update();
  }

  RxInt selectedTab = (-1).obs;

  void toggleTab(int value) {
    if (selectedTab.value == value) {
      selectedTab.value = -1;
    } else {
      selectedTab.value = value;
    }
  }

  RxInt focusedButtonIndex = 0.obs;
  void changeButton(int index) {
    focusedButtonIndex.value = index;
  }

  RxBool clear = false.obs;
  void clearAll() {
    clear.value = !clear.value;
  }

  final startDataController = TextEditingController();
  final endDataController = TextEditingController();

  void allFieldCanceled() {
    startDataController.text = " ";
    endDataController.text = " ";

    selectedCity.value = "City";
    selectedArea.value = "Area";
    selectedVenue.value = "Birthday Party";

    capacityStart.value = 0.0;
    capacityEnd.value = 1000.0;

    priceStart.value = 0.0;
    priceEnd.value = 12000.0;

    sliderValue.value = 0.0;
    ratingValue.value = 0.0;

    selectedTab.value = -1;
    focusedButtonIndex.value = 0;

    clear.value = false;
    update();
  }
}
