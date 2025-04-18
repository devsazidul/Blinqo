import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/payment_page/controller/sp_verification_submission_controller.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_payment_option.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpVerificationSubmission extends StatelessWidget {
  SpVerificationSubmission({super.key});
  final SpVerificationSubmissionController verificationSubmissionController =
      Get.put(SpVerificationSubmissionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFD9D9D9),
            child: Image.asset(IconPath.arrowLeftAlt),
          ),
        ),
        title: Text(
          'Verification Submission',
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
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
                TextFormField(
                  controller: verificationSubmissionController.spnameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: getTextStyle(
                      fontSize: 16,
                      color: AppColors.borderColor,
                    ),
                    hintText: "Guy Hawkins",
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      color: AppColors.textColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Obx(
                  () => Container(
                    width: double.infinity,
                    height: 61,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, bottom: 9.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Role',
                            style: getTextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 18,
                            child: PopupMenuButton<String>(
                              color: AppColors.primary,
                              onSelected:
                                  (value) => verificationSubmissionController
                                      .setRole(value),
                              itemBuilder: (context) {
                                return verificationSubmissionController.roles
                                    .map((role) {
                                      return PopupMenuItem<String>(
                                        value: role,
                                        child: Text(role),
                                      );
                                    })
                                    .toList();
                              },
                              padding: EdgeInsets.zero,
                              offset: Offset(0, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    verificationSubmissionController
                                        .selectedRole
                                        .value,
                                    style: getTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Image.asset(
                                      IconPath.arrowdown,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "National ID",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: verificationSubmissionController.addNidImage,
                  child: Obx(() {
                    return DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(16),
                      color: AppColors.appBarIcolor,
                      strokeWidth: 1.5,
                      dashPattern: [5, 3],
                      child: Container(
                        width: double.infinity,
                        height: 112,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child:
                            verificationSubmissionController
                                    .nidimageupload
                                    .isEmpty
                                ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          color: Color(0xFF898989),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                : PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      verificationSubmissionController
                                          .nidimageupload
                                          .length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.all(4),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          verificationSubmissionController
                                              .nidimageupload[index],
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Portfolio link",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller:
                      verificationSubmissionController.spProfileLinkController,
                  decoration: InputDecoration(
                    labelText: "Portfolio link",
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
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Short Bio",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller:
                      verificationSubmissionController.spShortBioController,
                  maxLines: 3,
                  decoration: InputDecoration(
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
                GestureDetector(
                  onTap: () {},
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(16),
                    color: AppColors.buttonColor,
                    strokeWidth: 1.5,
                    dashPattern: [2, 2],
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffFBF7EB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "\$99",
                          style: getTextStyle(
                            color: AppColors.buttonColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 112),
                CustomContinueButton(
                  onTap: () {
                    Get.to(SpPaymentOption());
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
  }
}
