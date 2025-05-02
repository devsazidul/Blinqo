import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/core/utils/constants/colors.dart';

import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/v_profile_app_bar.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/v_profile_edit_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VEditProfilePage extends StatelessWidget {
  static const String name = '/v_edit_profile_page';

  const VEditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: VProfileAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        child: ColoredBox(
          color:
              isDarkMode
                  ? AppColors.darkBackgroundColor
                  : AppColors.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 87),

                Form(
                  child: Column(
                    spacing: 8,
                    children: [
                      // first name text

                      /// First Name
                      VProfileEditTextFormField(label: 'First Name'),

                      /// Last Name
                      VProfileEditTextFormField(label: 'Last Name'),

                      /// Email
                      VProfileEditTextFormField(label: 'Email'),

                      /// Country
                      VProfileEditTextFormField(label: 'Country'),

                      /// City
                      VProfileEditTextFormField(label: 'City'),
                    ],
                  ),
                ),

                SizedBox(height: 40),
                CustomContinueButton(
                  onPress: () {
                    Get.back();
                  },
                  title: 'Save & Change',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
