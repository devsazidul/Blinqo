// import 'package:blinqo/core/common/styles/global_text_style.dart';
// import 'package:blinqo/core/utils/constants/colors.dart';
// import 'package:blinqo/core/utils/constants/icon_path.dart';
// import 'package:blinqo/features/profile/controller/profile_controller.dart';
// import 'package:blinqo/features/profile/widget/coustm_appbar.dart';
// import 'package:blinqo/features/profile/widget/coustm_elevated_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../widget/profile_edit_text_form_field.dart';

// class EditProfilePage extends StatelessWidget {
//   static const String name = '/edit_profile_page';
//   final ProfileController themeController = Get.put(ProfileController());

//   EditProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode = themeController.isDarkMode.value;
//     return Scaffold(
//       backgroundColor:
//           isDarkMode
//               ? AppColors.darkBackgroundColor
//               : AppColors.backgroundColor,
//       appBar: CoustmAppbar(
//         title: 'Edit Profile',
//         onPressed: () {
//           // Get.to(() => const MainProfileScreen());
//         },
//       ),
//       body: SingleChildScrollView(
//         child: ColoredBox(
//           color:
//               isDarkMode
//                   ? AppColors.darkBackgroundColor
//                   : AppColors.backgroundColor,
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 _buildProfileSection(context, themeController),
//                 SizedBox(height: 50),
//                 Form(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     spacing: 8,
//                     children: [
//                       Text(
//                         "Name",
//                         style: getTextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color:
//                               isDarkMode
//                                   ? AppColors.borderColor2
//                                   : AppColors.textColor,
//                         ),
//                       ),
//                       Obx(() {
//                         return ProfileEditTextFormField(
//                           hintText:
//                               themeController.userInfo.value?.data?.name ??
//                               "Adam",
//                         );
//                       }),
//                       Text(
//                         "User Name",
//                         style: getTextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color:
//                               isDarkMode
//                                   ? AppColors.borderColor2
//                                   : AppColors.textColor,
//                         ),
//                       ),
//                       Obx(() {
//                         return ProfileEditTextFormField(
//                           hintText:
//                               themeController
//                                   .userInfo
//                                   .value
//                                   ?.data
//                                   ?.profile
//                                   ?.name ??
//                               "Adam@",
//                         );
//                       }),
//                       Text(
//                         "Location",
//                         style: getTextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color:
//                               isDarkMode
//                                   ? AppColors.borderColor2
//                                   : AppColors.textColor,
//                         ),
//                       ),

//                       Obx(() {
//                         return ProfileEditTextFormField(
//                           hintText:
//                               themeController
//                                   .userInfo
//                                   .value
//                                   ?.data
//                                   ?.profile
//                                   ?.location ??
//                               "USA", // Fetch location from profile or use default "USA"
//                         );
//                       }),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: 40),
//                 EditCustomContinueButton(
//                   onTap: () {
//                     // Get.to(MainProfileScreen());
//                   },
//                   title: 'Save & Change',
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget _buildProfileSection(
//   BuildContext context,
//   ProfileController controller,
// ) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     spacing: 10,
//     children: [
//       Obx(() {
//         return Stack(
//           alignment: Alignment.bottomRight,
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundColor: Colors.grey[300],
//               child: ClipOval(
//                 child:
//                     controller.profileImage.value == null &&
//                             controller
//                                     .userInfo
//                                     .value
//                                     ?.data
//                                     ?.profile
//                                     ?.image
//                                     ?.path ==
//                                 null
//                         ? Image.asset(
//                           IconPath.profile01,
//                           width: 100,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         )
//                         : controller.profileImage.value != null
//                         ? Image.file(
//                           controller.profileImage.value!,
//                           width: 100,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         )
//                         : Image.network(
//                           controller
//                               .userInfo
//                               .value!
//                               .data!
//                               .profile!
//                               .image!
//                               .path!,
//                           width: 100,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         ),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               right: 0,
//               child: GestureDetector(
//                 onTap: () {
//                   controller.pickImage();
//                 },
//                 child: CircleAvatar(
//                   radius: 18,
//                   backgroundColor: Colors.transparent,
//                   child: Image.asset(
//                     IconPath.profileedit,
//                     width: 24,
//                     height: 24,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     ],
//   );
// }

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/profile/widget/coustm_appbar.dart';
import 'package:blinqo/features/profile/widget/coustm_elevated_button.dart';
import 'package:blinqo/features/profile/widget/profile_edit_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatelessWidget {
  static const String name = '/edit_profile_page';

  final ProfileController controller = Get.put(ProfileController());

  // ignore: use_super_parameters
  EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = controller.isDarkMode.value;

      if (controller.isLoadingUser.value) {
        return Scaffold(
          backgroundColor:
              isDarkMode
                  ? AppColors.darkBackgroundColor
                  : AppColors.backgroundColor,
          body: const Center(child: CircularProgressIndicator()),
        );
      }

      return Scaffold(
        backgroundColor:
            isDarkMode
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
        appBar: CoustmAppbar(
          title: 'Edit Profile',
          onPressed: () => Get.back(),
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
                children: [
                  _buildProfileSection(controller),
                  const SizedBox(height: 50),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:
                                isDarkMode
                                    ? AppColors.borderColor2
                                    : AppColors.textColor,
                          ),
                        ),
                        ProfileEditTextFormField(
                          controller: controller.nameController,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "User Name",
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:
                                isDarkMode
                                    ? AppColors.borderColor2
                                    : AppColors.textColor,
                          ),
                        ),
                        ProfileEditTextFormField(
                          controller: controller.userNameController,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Location",
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:
                                isDarkMode
                                    ? AppColors.borderColor2
                                    : AppColors.textColor,
                          ),
                        ),
                        ProfileEditTextFormField(
                          controller: controller.locationController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  EditCustomContinueButton(
                    title: 'Save & Change',
                    onTap: () async {
                      await controller.updateProfile(
                        name: controller.nameController.text.trim(),
                        userName: controller.userNameController.text.trim(),
                        location: controller.locationController.text.trim(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

Widget _buildProfileSection(ProfileController controller) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Obx(() {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: ClipOval(
                child:
                    controller.profileImage.value == null &&
                            controller
                                    .userInfo
                                    .value
                                    ?.data
                                    ?.profile
                                    ?.image
                                    ?.path ==
                                null
                        ? Image.asset(
                          IconPath.profile01,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                        : controller.profileImage.value != null
                        ? Image.file(
                          controller.profileImage.value!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                        : Image.network(
                          controller
                              .userInfo
                              .value!
                              .data!
                              .profile!
                              .image!
                              .path!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  controller.pickImage();
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    IconPath.profileedit,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    ],
  );
}
