import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';

class ContactPickerScreen extends StatelessWidget {
  final List<Contact> contacts;

  const ContactPickerScreen({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Contact',
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color:
                isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff333333),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (_, index) {
          final contact = contacts[index];
          final name = '${contact.name.first} ${contact.name.last}'.trim();
          final phone =
              contact.phones.isNotEmpty
                  ? contact.phones.first.number
                  : 'No phone number';

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xff32383D) : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color:
                    isDarkMode
                        ? const Color(0xff32383D)
                        : const Color(0xffEBEBEB),
                width: 1,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              title: Text(
                name,
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color:
                      isDarkMode
                          ? const Color(0xffEBEBEB)
                          : const Color(0xff333333),
                ),
              ),
              subtitle: Text(
                phone,
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffA1A1A1),
                ),
              ),
              onTap: () {
                _showRoleDialog(contact, isDarkMode);
              },
            ),
          );
        },
      ),
    );
  }

  bool _isValidEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _showRoleDialog(Contact contact, bool isDarkMode) {
    final TextEditingController roleController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xff32383D) : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Team Member',
                  style: getTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color:
                        isDarkMode
                            ? const Color(0xffEBEBEB)
                            : const Color(0xff333333),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: roleController,
                  decoration: InputDecoration(
                    labelText: 'Role *',
                    labelStyle: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffA1A1A1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorStyle: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Role is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address *',
                    labelStyle: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffA1A1A1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorStyle: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!_isValidEmail(value.trim())) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () {
                    if (formKey.currentState?.validate() ?? false) {
                      Get.back(); // Close the dialog
                      Get.back(
                        result: {
                          'name': '${contact.name.first} ${contact.name.last}',
                          'phone':
                              contact.phones.isNotEmpty
                                  ? contact.phones.first.number
                                  : '',
                          'email': emailController.text.trim(),
                          'role': roleController.text.trim(),
                        },
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff003366), Color(0xff0055a5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Add Member',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
