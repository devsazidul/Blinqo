import 'package:get/get.dart';

class SearchBerController extends GetxController{
  var searchQuery="".obs;

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}