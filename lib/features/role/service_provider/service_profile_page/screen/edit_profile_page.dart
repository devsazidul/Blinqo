import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_edit_profile_controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/profile_edit_text_form_field.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/show_profile_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpEditProfilePage extends StatelessWidget {
  SpEditProfilePage({super.key});

  final ServiceUserEditProfileController controller = Get.put(
    ServiceUserEditProfileController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFD9D9D9),
              child: Image.asset(IconPath.arrowLeftAlt),
            ),
          ),
        ),
        title: Text(
          'Edit Profile',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showPopupMenu(context);
            },
            icon: Image.asset(IconPath.moreVert, height: 22.5),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ColoredBox(
          color: AppColors.backgroundColor,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
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

                  Spacer(),
                  CustomContinueButton(onTap: () {}, title: 'Save & Change'),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
