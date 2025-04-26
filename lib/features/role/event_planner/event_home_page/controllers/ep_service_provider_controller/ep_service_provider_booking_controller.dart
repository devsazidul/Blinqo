import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpServiceProviderBookingController extends GetxController {
  var priceSet = false.obs;
  var currentStep = 1.obs;

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  RxString eventName = ''.obs;
  RxString eventPlannerName = ''.obs;
  RxString venue = ''.obs;
  RxString location = ''.obs;
  Rx<TimeOfDay> startTime = TimeOfDay(hour: 0, minute: 0).obs;
  Rx<TimeOfDay> endTime = TimeOfDay(hour: 0, minute: 0).obs;
  RxString numberOfGuests = ''.obs;
  RxString eventType = 'Birthday'.obs;
}
