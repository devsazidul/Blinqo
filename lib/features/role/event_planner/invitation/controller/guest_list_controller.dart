import 'package:get/get.dart';

class GuestListController extends GetxController {
  List<dynamic> _guestList = [
    {
      'name': 'Guest Name',
      'Address': '24 Main St, Anytown, USA',
      'status': 'Accepted',
    },
  ];

  List<dynamic> get guestList => _guestList;

  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < 30; i++) {
      _guestList.add({
        'name': 'Guest Name $i', // Ensure 'name' is not null
        'address':
            '24$i Main St, Anytown, USA', // Corrected 'Address' to 'address'
        'status':
            i % 3 == 0
                ? 'Accepted'
                : i % 3 == 1
                ? 'Denied'
                : 'Pending',
      });
    }
  }

  // filter guest list by status
  void filterGuestList(String status) {
    _guestList.clear();
    onInit();
    if (status == 'Accepted') {
      onInit();
      _guestList =
          _guestList.where((guest) => guest['status'] == 'Accepted').toList();
    } else if (status == 'Pending') {
      onInit();
      _guestList =
          _guestList.where((guest) => guest['status'] == 'Pending').toList();
    } else if (status == 'Denied') {
      onInit();
      _guestList =
          _guestList.where((guest) => guest['status'] == 'Denied').toList();
    }

    update();
  }
}
