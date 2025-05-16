import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';

import 'package:get/get.dart';

class CreateShiftController extends GetxController {
  Future<void> createShift() async {
    // ignore: unused_local_variable
    final reponse = await OwnerNetworkCaller().postRequest(
      Url: Urls.createShift,
      body: {
        "venueId": "1c7e5e4a-f5d6-4c89-91c3-b1c937a2aeb9",
        "startTime": "2025-04-21T09:00:00.000Z",
        "endTime": "2025-04-21T17:00:00.000Z",
        "duration": 480,
        "shiftName": "Morning Shift",
      },
    );
  }
}
