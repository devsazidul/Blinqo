import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FacilityController extends GetxController {
  RxList<String> selectedFacilities = <String>[].obs;

  List<String> allFacilities = [
    'Storage & lighting',
    'Sound System',
    'Barservices',
    'Elevator',
    'Restroom',
    'Event Staff',
  ];

  void addFacility(String facility) {
    if (!selectedFacilities.contains(facility)) {
      selectedFacilities.add(facility);
    }
  }

  void removeFacility(String facility) {
    selectedFacilities.remove(facility);
  }
}
