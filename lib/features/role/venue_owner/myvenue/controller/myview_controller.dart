import 'package:get/get.dart';

class MyVenueController extends GetxController {
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
}
