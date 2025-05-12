import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/controllers/verification_submission_controller.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/screens/v_payment_method.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/widgets/photo_upload_widget.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/widgets/v_payment_app_bar.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/widgets/event_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VVerificationSubmissionScreen extends StatelessWidget {
  const VVerificationSubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    Get.put(VenueOwnerProfileController());
    final bool isDarkMode =
        Get.find<VenueOwnerProfileController>().isDarkMode.value;
    VerificationSubmissionController controller = Get.put(
      VerificationSubmissionController(),
    );
    if (controller.nameTEController.text.isEmpty) {
      controller.nameTEController.text =
          EventAuthController.profileInfo?.profile?.name ?? '';
    }
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff151515) : const Color(0xffF9FAFB),
      appBar: const VPaymentAppBar(title: 'Verification Submission'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                TextFieldWidget(
                  enabled: false,
                  hintText: 'Name',
                  labelText: 'Name',
                  controller: controller.nameTEController,
                ),
                const SizedBox(height: 24),
                Text(
                  'Nation ID',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color:
                        isDarkMode
                            ? AppColors.borderColor2
                            : const Color(0xff333333),
                  ),
                ),
                const SizedBox(height: 16),
                const PhotoUploadWidget(imageKey: 'national_id'),

                const SizedBox(height: 24),
                Text(
                  'Business Registration Certificate',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color:
                        isDarkMode
                            ? AppColors.borderColor2
                            : const Color(0xff333333),
                  ),
                ),
                const SizedBox(height: 16),
                const PhotoUploadWidget(imageKey: 'business_cert'),
                // Use "business_cert" for this section
                const SizedBox(height: 24),
                Text(
                  'Short Bio',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color:
                        isDarkMode
                            ? AppColors.borderColor2
                            : const Color(0xff333333),
                  ),
                ),
                const SizedBox(height: 16),
                TextFieldWidget(
                  hintText: 'Bio',
                  labelText: 'Bio',
                  maxLines: 2,
                  controller: controller.bioTEController,
                ),
                const SizedBox(height: 48),
                // Get Verified Button
                GestureDetector(
                  onTap: () {
                    controller.submitVerification();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xff003366),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Get Verified',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hintText,
    String labelText, [
    int? maxLines = 1,
  ]) {
    final bool isDarkMode =
        Get.find<VenueOwnerProfileController>().isDarkMode.value;
    return TextField(
      style: getTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: isDarkMode ? const Color(0xffA1A1A1) : const Color(0xff333333),
      ),
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? const Color(0xffA1A1A1) : const Color(0xff767676),
        ),
        hintText: hintText,
        hintStyle: getTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: isDarkMode ? const Color(0xffA1A1A1) : const Color(0xff767676),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color:
                isDarkMode ? const Color(0xffAFB1B6) : const Color(0xffABB7C2),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color:
                isDarkMode ? const Color(0xffAFB1B6) : const Color(0xffABB7C2),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color:
                isDarkMode ? const Color(0xffAFB1B6) : const Color(0xffABB7C2),
            width: 1,
          ),
        ),
      ),
    );
  }
}
