import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SpBookingController extends GetxController {
  RxString price = ''.obs;

  TextEditingController priceController = TextEditingController();

  void updatePrice(String newPrice) {
    price.value = newPrice;
  }
}
