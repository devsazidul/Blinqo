import 'package:blinqo/core/common/widgets/custom_appbar_widget.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/profile/widget/f_custom_button.dart';
import 'package:blinqo/features/profile/widget/profile_edit_text_form_field.dart';
import 'package:blinqo/features/profile/widget/show_profile_popup_menu.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  static const String name = '/sp_profile_edit';
  EditProfileScreen({super.key});

  final ServiceUserEditProfileController controller = Get.put(
    ServiceUserEditProfileController(),
  );

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.find<ProfileController>().isDarkMode.value;
    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: CustomAppBarWidget(
        title: 'Edit Profile',
        actions: [
          IconButton(
            icon: Image.asset(
              IconPath.moreVert,
              width: 24,
              height: 24,
              color: isDarkMode ? Colors.white : AppColors.textColor,
            ),
            onPressed: () {
              showPopupMenu(context);
            },
          ),
        ],
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
                        controller: controller.nameController,
                      ),

                      /// Last Name
                      ProfileEditTextFormField(label: 'Last Name'),

                      /// Email
                      ProfileEditTextFormField(label: 'Email'),

                      /// Country
                      ProfileEditTextFormField(label: 'Country'),

                      /// City
                      ProfileEditTextFormField(label: 'City'),
                    ],
                  ),
                ),

                SizedBox(height: 40),
                FCustomButton(child: Text('Save Change')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
