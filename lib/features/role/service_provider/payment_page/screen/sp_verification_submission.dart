import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_continue_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/payment_page/controller/sp_verification_submission_controller.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_payment_option.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_profile_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpVerificationSubmission extends StatelessWidget {
  const SpVerificationSubmission({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpProfileController());

    final verificationSubmissionController = Get.put(
      SpVerificationSubmissionController(),
    );

    verificationSubmissionController.spNameController.text =
        "@${SpAuthController.spUser?.profile?.name}";

    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor:
                    themeMode == ThemeMode.dark
                        ? AppColors.appBarArrowIconColor
                        : AppColors.appBarIcolor,
                child: Image.asset(
                  IconPath.arrowleft,
                  width: 16,
                  height: 12,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.primary
                          : AppColors.textColor,
                ),
              ),
            ),
          ),
          title: Text(
            'Verification Submission',
            style: getTextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.primary
                      : AppColors.textColor,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 32),

                  //* ------------------ Name Text Field ------------------
                  TextField(
                    enabled: false,
                    controller:
                        verificationSubmissionController.spNameController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  // SizedBox(height: 20),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     'Role',
                  //     style: getTextStyle(fontSize: 12, color: Colors.grey),
                  //   ),
                  // ),
                  // SizedBox(height: 10),

                  // ------------------ Role Dropdown ------------------
                  // TextField(
                  //   decoration: InputDecoration(
                  //     suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                  //     enabled: false,
                  //     floatingLabelBehavior: FloatingLabelBehavior.always,
                  //     labelText: "Role",
                  //   ),
                  //   controller: verificationSubmissionController.roleController,
                  // ),
                  // DropdownButtonFormField(
                  //   value:
                  //       SpAuthController.profileInfoModel?.serviceProviderRole,
                  //   items: [],
                  //   onChanged: (value) {},
                  //   decoration: InputDecoration(
                  //     hintText:
                  //         SpAuthController
                  //             .profileInfoModel
                  //             ?.serviceProviderRole,
                  //     floatingLabelBehavior: FloatingLabelBehavior.always,
                  //     labelText: "Role",
                  //     labelStyle: getTextStyle(
                  //       fontSize: 16,
                  //       color: AppColors.borderColor,
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderSide: BorderSide(
                  //         color: const Color.fromARGB(255, 215, 216, 220),
                  //         width: 1.0,
                  //       ),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(
                  //         color: const Color.fromARGB(255, 215, 216, 220),
                  //         width: 1.0,
                  //       ),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(
                  //         color: const Color.fromARGB(255, 219, 221, 227),
                  //         width: 1.0,
                  //       ),
                  //     ),
                  //   ),
                  //   icon: Image.asset(
                  //     IconPath.arrowdown,
                  //     width: 20,
                  //     height: 20,
                  //     color: AppColors.borderColor,
                  //   ),
                  // ),
                  // Obx(
                  //   () => Container(
                  //     width: double.infinity,
                  //     height: 61,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       border: Border.all(
                  //         color: AppColors.borderColor,
                  //         width: 1,
                  //       ),
                  //     ),
                  //     child: Padding(
                  //       padding: EdgeInsets.only(left: 8, bottom: 9.5),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           SizedBox(
                  //             height: 18,
                  //             child: PopupMenuButton<String>(
                  //               color: AppColors.primary,
                  //               onSelected:
                  //                   (value) => verificationSubmissionController
                  //                       .setRole(value),
                  //               itemBuilder: (context) {
                  //                 return verificationSubmissionController.roles
                  //                     .map((role) {
                  //                       return PopupMenuItem<String>(
                  //                         value: role,
                  //                         child: Text(
                  //                           role,
                  //                           style: getTextStyle(
                  //                             fontSize: 14,
                  //                             color: Colors.black,
                  //                           ),
                  //                         ),
                  //                       );
                  //                     })
                  //                     .toList();
                  //               },
                  //               padding: EdgeInsets.zero,
                  //               offset: Offset(0, 20),
                  //               child: Row(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Text(
                  //                     verificationSubmissionController
                  //                         .selectedRole
                  //                         .value,
                  //                     style: getTextStyle(
                  //                       fontSize: 14,
                  //                       fontWeight: FontWeight.w600,
                  //                       color:
                  //                           themeMode == ThemeMode.dark
                  //                               ? AppColors.primary
                  //                               : Colors.black,
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding: EdgeInsets.symmetric(
                  //                       horizontal: 10,
                  //                     ),
                  //                     child: Image.asset(
                  //                       IconPath.arrowdown,
                  //                       width: 20,
                  //                       height: 20,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 24),

                  //* ------------------ NID Image Upload ------------------
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "National ID",
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.primary
                                : AppColors.textColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  _buildImageUploadSection(
                    themeMode,
                    verificationSubmissionController.nidImage.value,
                    true,
                  ),

                  SizedBox(height: 24),

                  //* ------------------ Trade License Image Upload ------------------
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Trade License",
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.primary
                                : AppColors.textColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  _buildImageUploadSection(
                    themeMode,
                    verificationSubmissionController.tradeLicenseImage.value,
                    false,
                  ),

                  SizedBox(height: 24),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Short Bio",
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.primary
                                : AppColors.textColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  //* ------------------ Short Bio Text Field ------------------
                  TextFormField(
                    controller:
                        verificationSubmissionController.spShortBioController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Bio",
                      labelStyle: getTextStyle(
                        fontSize: 16,
                        color: AppColors.borderColor,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: DottedBorder(
                  //     borderType: BorderType.RRect,
                  //     radius: Radius.circular(16),
                  //     color: AppColors.buttonColor,
                  //     strokeWidth: 1.5,
                  //     dashPattern: [2, 2],
                  //     child: Container(
                  //       width: double.infinity,
                  //       height: 50,
                  //       decoration: BoxDecoration(
                  //         color: Color(0xffFBF7EB),
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //       child: Center(
                  //         child: Text(
                  //           "\$99",
                  //           style: getTextStyle(
                  //             color: AppColors.buttonColor,
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.w700,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 112),

                  //* ------------------ Get Verified Button ------------------
                  CustomContinueButton(
                    onPress: () async {
                      // print(
                      //   "Profile ID: ${SpAuthController.profileInfoModel?.id}",
                      // );
                      bool isSuccess =
                          await verificationSubmissionController.getVerified();
                      if (isSuccess) {
                        Get.to(SpPaymentOption());
                      }
                    },
                    title: "Get Verified",
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildImageUploadSection(
    ThemeMode themeMode,
    File? image,
    bool isNidImage,
  ) {
    return GetBuilder<SpVerificationSubmissionController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () async {
            await controller.addImage(isNidImage);
          },
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(16),
            color: AppColors.appBarIcolor,
            strokeWidth: 1.5,
            dashPattern: [5, 3],
            child: Container(
              width: double.infinity,
              height: 112,
              decoration: BoxDecoration(
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.textFieldDarkColor
                        : AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child:
                  image == null
                      ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              IconPath.niduploadlogo,
                              height: 32,
                              width: 32,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Click to upload',
                              style: getTextStyle(
                                color: Color(0xff0EA5E9),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'JPG, JPEG, PNG less than 1MB',
                              style: getTextStyle(
                                color: AppColors.subTextColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
                      : Padding(
                        padding: EdgeInsets.all(4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            image,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[200],
                                child: Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
            ),
          ),
        );
      },
    );
  }
}
