import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentOptionController extends GetxController {
  // Map to store the selection state for each payment option
  var selections = <String, RxBool>{}.obs;

  // Initialize the selection state for a payment option if not already present
  void initializeSelection(String cardName) {
    if (!selections.containsKey(cardName)) {
      selections[cardName] = false.obs;
    }
  }

  // Initialize selection states for multiple payment options at once
  void initializeSelections(List<String> cardNames) {
    for (String cardName in cardNames) {
      initializeSelection(cardName);
    }
    debugPrint("Initialized selections for: $cardNames");
  }

  // Toggle the selection state for a specific payment option
  void toggleSelection(String cardName) {
    if (selections.containsKey(cardName)) {
      selections[cardName]!.value = !selections[cardName]!.value;
      debugPrint("Toggled selection for $cardName: ${selections[cardName]!.value}");
    }
  }
}