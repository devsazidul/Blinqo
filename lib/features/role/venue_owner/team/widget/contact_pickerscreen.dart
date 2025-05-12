import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';

class ContactPickerScreen extends StatelessWidget {
  final List<Contact> contacts;

  const ContactPickerScreen({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Contact')),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (_, index) {
          final contact = contacts[index];
          final name = '${contact.name.first} ${contact.name.last}';
          return ListTile(
            title: Text(name),
            onTap: () {
              _showRoleDialog(contact);
            },
          );
        },
      ),
    );
  }

  void _showRoleDialog(Contact contact) {
    final TextEditingController roleController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: Color(0xffF4F4F4),
        content: Container(
          decoration: BoxDecoration(),
          width: 353, // এখানে width বাড়িয়ে দিলাম
          height: 295, // height ও দিলাম (ইচ্ছা মত বড় ছোট করতে পারো)
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: roleController,
                decoration: InputDecoration(labelText: 'Role'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email Address'),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (roleController.text.trim().isNotEmpty) {
                    Get.back(); // Close the dialog
                    Get.back(
                      result: {
                        'firstName': contact.name.first,
                        'lastName': contact.name.last,
                        'role': roleController.text.trim(),
                      },
                    );
                  } else {
                    Get.snackbar("Error", "Role cannot be empty!");
                  }
                },
                child: Container(
                  height: 48,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xff003366),
                    // Button color
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Add Team Member',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffF4F4F4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
