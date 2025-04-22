import 'package:get/get.dart';

class SearchDetailsController extends GetxController {
  RxString selectedCity = "City".obs;
  List<String> city = ["City", "New Work", "London", "Canada"];
  void updateSelectedCity(String value) {
    selectedCity.value = value;
  }

  RxString selectedArea = "Area".obs;
  List<String> area = ["Area", "Japan", "France", "Australia"];
  void updateSelectedArea(String value) {
    selectedArea.value = value;
  }

  RxString selectedVenue = "Brithday Party".obs;
  List<String> venueType = [
    "Brithday Party",
    "Wedding",
    "Corporate Event",
    "Bachlor Party",
    "Anniversary",
    "Others",
  ];
  void updateVenue(String value) {
    selectedVenue.value = value;
  }

  ///Capacity///
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

  ///Price Range///
  RxDouble priceStart = 0.0.obs;
  void priceRangeStart(double value) {
    priceStart.value = value;
  }

  var priceEnd = 12000.0.obs;

  void priceRangeEnd(double value) {
    priceEnd.value = value;
  }

  RxDouble sliderValue = 0.0.obs;
  void updateSliderValue(double value) {
    sliderValue.value = value;
  }

  // RxInt selectedRatings = (-1).obs;
  // void toggleRatings() {
  //   selectedRatings.value != selectedRatings.value;
  // }
  RxInt selectedTab = (-1).obs;

  void toggleTab(int value) {
    if (selectedTab.value == value) {
      selectedTab.value = -1; // Unselect if already selected
    } else {
      selectedTab.value = value; // Select the radio button
    }
  }

  RxInt focusedButtonIndex = 0.obs;
  void changeButton(int index) {
    focusedButtonIndex.value = index;
  }
}
