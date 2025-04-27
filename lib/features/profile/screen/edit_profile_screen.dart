import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/screen/profile_screen.dart';
import 'package:blinqo/features/profile/widget/coustm_appbar.dart';
import 'package:blinqo/features/profile/widget/coustm_elevated_button.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/profile_edit_text_form_field.dart';

class EditProfilePage extends StatelessWidget {
  static const String name = '/edit_profile_page';

  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: CoustmAppbar(
        title: 'Edit Profile',
        onPressed: () {
          Get.to(() => const MainProfileScreen());
        },
      ),
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
                      ProfileEditTextFormField(
                        label: 'First Name',
                        hintText: "Adam",
                      ),

                      /// Last Name
                      ProfileEditTextFormField(
                        label: 'Last Name',
                        hintText: "Jonh",
                      ),

                      /// Email
                      ProfileEditTextFormField(
                        label: 'Email',
                        hintText: "abcdefg@gmail.com",
                      ),

                      /// Country
                      ProfileEditTextFormField(
                        label: 'Country',
                        hintText: "USA",
                      ),

                      /// City
                      ProfileEditTextFormField(
                        label: 'City',
                        hintText: "New York",
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),
                EditCustomContinueButton(onTap: () {}, title: 'Save & Change'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
