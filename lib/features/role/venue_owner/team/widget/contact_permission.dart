import 'package:blinqo/features/role/venue_owner/team/widget/contact_pickerscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
Future<Map<String, String>?> pickContact(BuildContext context) async {
  final permissionStatus = await Permission.contacts.request();

  if (permissionStatus.isGranted) {
    final contacts = await FlutterContacts.getContacts(withProperties: true);

    // ContactPickerScreen থেকে result রিটার্ন করো
    final result = await Get.to<Map<String, String>>(
      () => ContactPickerScreen(contacts: contacts),
    );

    return result;
  } else {
    Get.snackbar("Permission", "Contacts Permission লাগবে");
  }

  return null;
}
