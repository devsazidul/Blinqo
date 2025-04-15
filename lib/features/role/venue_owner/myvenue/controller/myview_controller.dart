import 'package:get/get.dart';

class myvenuecontroller extends GetxController{
  var selectedShapes = <String>[].obs;

  List<String> tableShapeOptions = [
    "Round",
    "Oval",
    "Half-Moon",
    "Banquet",
    "Square",
    "Hexagonal",
  ];

  void toggleShape(String shape) {
    if (selectedShapes.contains(shape)) {
      selectedShapes.remove(shape);
    } else {
      selectedShapes.add(shape);
    }
  }
}

