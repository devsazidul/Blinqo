
import 'package:get/get.dart';

// Controller to handle the price input and update
class PriceController extends GetxController {
  final RxString price = ''.obs;

  void submitPrice(String newPrice) {
    if (newPrice.isNotEmpty) {
      price.value = newPrice; // Update the price
      Get.back(); // Close the dialog
      Get.snackbar('Success', 'Price set to $newPrice');
    } else {
      Get.snackbar('Error', 'Please enter a price');
    }
  }
}