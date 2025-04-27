import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/widget/profile_edit_text_form_field.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_edit_profile_controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/sp_profile_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpEditProfilePage extends StatelessWidget {
  static const String name = '/sp_profile_edit';
  SpEditProfilePage({super.key});

  final ServiceUserEditProfileController controller = Get.put(
    ServiceUserEditProfileController(),
  );

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 87),
                // Obx(() {
                //   return Text(
                //     "first name is ${controller.name.value}",
                //     style: getTextStyle(),
                //   );
                // }),
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
                CustomContinueButton(
                  onTap: () {
                    Navigator.pop(context);
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
