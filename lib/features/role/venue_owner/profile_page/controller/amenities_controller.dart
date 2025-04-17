import 'package:get/get.dart';

class AmenitiesController extends GetxController {
  // New instance of the controller

  // Reactive list of selected amenities (initially empty)
  final RxList<String> selectedAmenities = <String>[].obs;

  // Reactive list of available amenities (predefined)
  final RxList<String> availableAmenities = [
    'WiFi',
    'Parking',
    'AC',
    'Pool',
    'Stage & Lighting',
    'Sound System',
    'Bar Services',
    'Elevator',
    'Restroom',
    'Event Staff',
    'In-House Catering',
  ].obs;

  // Method to select an amenity
  void selectAmenity(String amenity) {
    availableAmenities.remove(amenity);
    selectedAmenities.add(amenity);
  }
  // Method to remove an amenity
  void removeAmenity(String amenity) {
    selectedAmenities.remove(amenity);
    availableAmenities.add(amenity);
  }
  // Method to add a custom amenity
  void addCustomAmenity(String amenity) {
    if (amenity.isNotEmpty) {
      selectedAmenities.add(amenity);
    }
  }
}