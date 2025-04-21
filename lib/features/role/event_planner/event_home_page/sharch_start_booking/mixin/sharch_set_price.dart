import 'package:get/get.dart';

mixin SharchSetPrice {
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
