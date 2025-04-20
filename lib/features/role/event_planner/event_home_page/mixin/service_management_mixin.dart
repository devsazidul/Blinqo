import 'package:get/get_rx/src/rx_types/rx_types.dart';

mixin ServiceManagementMixin {
  List<String> availableServices = [
    'Photography',
    'Videography',
    'DJ Brand',
    'Catering',
  ];

  List<String> serviceImages = [
    'assets/images/Group.png',
    'assets/images/videography.png',
    'assets/images/decoration.png',
    'assets/images/catering.png',
  ];

  RxList<String> selectedServices = <String>[].obs;

  void addService(String service) {
    if (!selectedServices.contains(service)) {
      selectedServices.add(service);
    }
  }

  void removeService(String service) {
    selectedServices.remove(service);
  }

  bool isServiceSelected(String service) {
    return selectedServices.contains(service);
  }
}
