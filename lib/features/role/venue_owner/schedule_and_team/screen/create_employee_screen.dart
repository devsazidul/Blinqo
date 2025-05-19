import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/controller/create_employee_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Screen for creating a new employee/team member
/// Allows input of employee details like name, email, phone, and role
class CreateEmployeeScreen extends StatelessWidget {
  final bool isEdit;
  final String venueId;
  final int index;
  const CreateEmployeeScreen({super.key, required this.venueId, this.isEdit = false, required this.index});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final CreateEmployeeController controller = Get.put(
      CreateEmployeeController(),
    );
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff151515) : AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Team Member' : 'Add Team Member'),
        titleTextStyle: getTextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff000000),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        backgroundColor:
            isDarkMode ? const Color(0xff151515) : AppColors.backgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                // Header
                _buildHeader(isDarkMode),
                const SizedBox(height: 16),
                // Employee Form
                _buildEmployeeForm(controller, isDarkMode, formKey),
                const SizedBox(height: 40),
                // Submit Button
                _buildSubmitButton(controller, formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the header section with title
  Widget _buildHeader(bool isDarkMode) {
    return Text(
      'Employee Information',
      style: getTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff000000),
      ),
    );
  }

  /// Builds the employee information form fields
  Widget _buildEmployeeForm(
    CreateEmployeeController controller,
    bool isDarkMode,
    GlobalKey<FormState> formKey,
  ) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _buildTextField(
            controller: controller.firstNameController,
            labelText: 'First Name',
            isDarkMode: isDarkMode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: controller.lastNameController,
            labelText: 'Last Name',
            isDarkMode: isDarkMode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: controller.emailController,
            labelText: 'Email Address',
            isDarkMode: isDarkMode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email address';
              } else if (!value.contains('@') || !value.contains('.')) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: controller.phoneController,
            labelText: 'Phone Number',
            isDarkMode: isDarkMode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Phone number is required';
              }
              final regex = RegExp(r'^\+\d{1,3}\d{4,15}$');
              if (!regex.hasMatch(value)) {
                return 'Invalid phone number format. Use E.164 (e.g., +141555550123)';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: controller.roleController,
            labelText: 'Role',
            isDarkMode: isDarkMode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your role';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  /// Builds a common text field with consistent styling
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required bool isDarkMode,
    required String? Function(String?)? validator,
  }) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        validator: validator,
        style: getTextStyle(
          color: isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff333333),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffABB7C2), width: 1),
          ),
          labelText: labelText,
          labelStyle: getTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color:
                isDarkMode ? const Color(0xffC0C0C0) : const Color(0xff767676),
          ),
        ),
      ),
    );
  }

  /// Builds the submit button
  Widget _buildSubmitButton(
    CreateEmployeeController controller,
    GlobalKey<FormState> formKey,
  ) {
    return GestureDetector(
      onTap: () {
        if (!formKey.currentState!.validate()) {
          return;
        }
        controller.createEmployee(venueId);
      },
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xff003366),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xff003366), width: 1),
        ),
        child: Center(
          child: Text(
            isEdit ? 'Update Team Member' : 'Add Team Member',
            style: getTextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xffF4F4F4),
            ),
          ),
        ),
      ),
    );
  }
}
