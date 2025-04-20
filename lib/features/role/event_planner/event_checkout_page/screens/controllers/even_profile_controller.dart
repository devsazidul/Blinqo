import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/mixin/gender.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../mixin/image_packer.dart';
import '../mixin/map_location.dart';

class EvenProfileController extends GetxController
    with ImagePackerMixin, GenderMixin, MapLocation {
  final spnameController = TextEditingController();
  final spdescriptionController = TextEditingController();

  final splocationController = TextEditingController();

  // This is the current location input by the user
  var currentLocation = ''.obs;

  @override
  void dispose() {
    spnameController.dispose();
    spdescriptionController.dispose();
    splocationController.dispose();
    super.dispose();
  }

  // Function to search location based on input in splocationController
  void searchLocationForProfile() {
    if (splocationController.text.isNotEmpty) {
      searchLocation(splocationController.text);
      currentLocation.value = splocationController.text;
    } else {
      Get.snackbar(
        'Empty Location',
        'Please enter a location',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
