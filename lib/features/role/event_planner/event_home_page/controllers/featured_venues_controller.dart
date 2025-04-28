import 'package:get/get.dart';

class FeaturedVenuesController extends GetxController {
  RxList<bool> fvIsFavorite = [false, false, false, false, false].obs;
  RxList<bool> vnIsFavorite = [false, false, false, false, false].obs;

  // Toggle favorite state (if needed for other functionality)
  void toggleFavourite(int index) {
    fvIsFavorite[index] = !fvIsFavorite[index];
  }

  // Toggle favorite state (if needed for other functionality)
  void toggleFavouritevn(int index) {
    vnIsFavorite[index] = !vnIsFavorite[index];
  }
}
