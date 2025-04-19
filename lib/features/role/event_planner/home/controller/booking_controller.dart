import 'package:get/get.dart';

class BookingController extends GetxController {
  // Represents the current step in the booking timeline
  var currentStep = 0.obs;

  // Function to change to the next step
  void nextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
    }
  }

  // Function to change to the previous step
  void prevStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }
}
