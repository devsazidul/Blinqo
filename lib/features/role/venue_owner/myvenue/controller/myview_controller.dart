import 'dart:io';

import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class MyVenueController extends GetxController {
  final searchText = ''.obs;

  final List<Map<String, String>> allVenues = [
    {
      "title": "The Grand Hall",
      "address": "New York",
      "guest": "300 Guests",
      "rating": "4.5",
      "image": ImagePath.myvenue1,
    },
    {
      "title": "The Crystal Room",
      "address": "Los Angeles",
      "guest": "250 Guests",
      "rating": "4.7",
      "image": ImagePath.myvenue2,
    },
  ];

  List<Map<String, String>> get filteredVenues {
    if (searchText.isEmpty) return allVenues;

    List<Map<String, String>> matchFirst = [];
    List<Map<String, String>> matchRest = [];

    for (var venue in allVenues) {
      final title = venue['title']!.toLowerCase();
      final search = searchText.value.toLowerCase();

      if (title.startsWith(search)) {
        matchFirst.add(venue);
      } else if (title.contains(search)) {
        matchRest.add(venue);
      }
    }

    return [...matchFirst, ...matchRest];
  }

  void updateSearch(String text) {
    searchText.value = text;
  }
  var selectedTableShapes = <String>[].obs;
  var selectedSeatingStyles = <String>[].obs;
  var selectedLightingStyles = <String>[].obs;
  var selectedFlowerColor = <String>[].obs;
  var selectedFlowerType = <String>[].obs;
  var selectedFragrance = <String>[].obs;

  List<String> tableShapeOptions = [
    "Round",
    "Oval",
    "Half-Moon",
    "Banquet",
    "Square",
    "Hexagonal",
  ];

  List<String> seatingStyle = [
    "Banquet",
    "Theater",
    "Classroom",
    "Cabaret",
    "U-Shaped",
    "Cocktail",
  ];
  List<String> lightingStyle = [
    "Ambient",
    "Spotlighting",
    "Fairy",
    "Chandeliers",
    "LED",
    "Neon",
    "Gobo",
  ];

  List<String> flowerColor = [
    "White",
    "Red",
    "Yellow",
    "Pink",
    "Purple",
    "Blue",
    "Green",
    "Orange",
  ];
  List<String> flowerType = [
    "Roses",
    "Peonies",
    "Lilies",
    "Orchids",
    "Tulips",
    "Sunflowers",
    "Hydrangeas",
  ];
  List<String> frogrance = [
    "Floral Scents",
    "Citrus Scents",
    "Herba; Scents",
    "Oceanic Scents",
    "Woody Scents",
    "Spicy",
  ];
  void toogleFrance(String shape) {
    if (selectedFragrance.contains(shape)) {
      selectedFragrance.remove(shape);
    } else {
      selectedFragrance.add(shape);
    }
  }

  void toogleFlowerType(String shape) {
    if (selectedFlowerType.contains(shape)) {
      selectedFlowerType.remove(shape);
    } else {
      selectedFlowerType.add(shape);
    }
  }

  void toogleFlowerColor(String shape) {
    if (selectedFlowerColor.contains(shape)) {
      selectedFlowerColor.remove(shape);
    } else {
      selectedFlowerColor.add(shape);
    }
  }

  void tooggleLightingStyle(String shape) {
    if (selectedLightingStyles.contains(shape)) {
      selectedLightingStyles.remove(shape);
    } else {
      selectedLightingStyles.add(shape);
    }
  }

  void toggleTableShape(String shape) {
    if (selectedTableShapes.contains(shape)) {
      selectedTableShapes.remove(shape);
    } else {
      selectedTableShapes.add(shape);
    }
  }

  void toggleSeatingStyle(String style) {
    if (selectedSeatingStyles.contains(style)) {
      selectedSeatingStyles.remove(style);
    } else {
      selectedSeatingStyles.add(style);
    }
  }
   var favoriteList = <bool>[false, false].obs;

  void toggleFavorite(int index) {
    favoriteList[index] = !favoriteList[index];
  }
    var pickedImage = Rx<File?>(null);

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedImage.value = File(image.path);
    }
  }
    Rx<LatLng> selectedLocation = LatLng(23.8103, 90.4125).obs; // Initial (Dhaka)

  void updateLocation(LatLng newLocation) {
    selectedLocation.value = newLocation;
  }
}
