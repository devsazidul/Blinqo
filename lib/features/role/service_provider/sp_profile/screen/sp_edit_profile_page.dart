import 'package:blinqo/core/common/widgets/custom_continue_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/profile/widget/profile_edit_text_form_field.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_edit_profile_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_profile_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/widget/sp_profile_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpEditProfilePage extends StatelessWidget {
  static const String name = '/sp_profile_edit';
  SpEditProfilePage({super.key});

  final SpEditProfileController controller = Get.put(SpEditProfileController());

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.find<SpProfileController>().isDarkMode.value;

    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: SpProfileAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        child: ColoredBox(
          color:
              isDarkMode
                  ? AppColors.darkBackgroundColor
                  : AppColors.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 87),

                  /// First Name
                  ProfileEditTextFormField(
                    label: 'First Name',
                    controller: controller.fastNameController,
                    validator: controller.validateFastName,
                    keyboardType: TextInputType.name,
                  ),

                  const SizedBox(height: 16),

                  /// Last Name
                  ProfileEditTextFormField(
                    label: 'Last Name',
                    controller: controller.lastNameController,
                    validator: controller.validateLastName,
                    keyboardType: TextInputType.name,
                  ),

                  const SizedBox(height: 16),

                  /// Email
                  ProfileEditTextFormField(
                    label: 'Email',
                    controller: controller.emailController,
                    validator: controller.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),

                  /// Country
                  ProfileEditTextFormField(
                    label: 'Country',
                    controller: controller.countryController,
                    validator: controller.validateCountry,
                  ),

                  const SizedBox(height: 16),

                  /// City
                  ProfileEditTextFormField(
                    label: 'City',
                    controller: controller.cityController,
                    validator: controller.validateCity,
                  ),

                  const SizedBox(height: 40),

                  CustomContinueButton(
                    onPress: () {
                      if (controller.validateForm()) {
                        controller.saveForm();
                        Navigator.pop(context);
                      }
                    },
                    title: 'Save & Change',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
