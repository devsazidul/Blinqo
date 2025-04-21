import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/screens/v_thank_you_screen.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/widgets/photo_upload_widget.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/widgets/v_payment_app_bar.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VVerificationSubmissionScreen extends StatelessWidget {
  const VVerificationSubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xff151515) : const Color(0xffF9FAFB),
      appBar: VPaymentAppBar(title: 'Verification Submission'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                _buildTextField('Name', 'Name'),
                SizedBox(height: 24),
                Text(
                  'Nation ID',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color:
                        isDarkMode ? AppColors.borderColor2 : Color(0xff333333),
                  ),
                ),
                SizedBox(height: 16),

                PhotoUploadWidget(),
                SizedBox(height: 24),
                Text(
                  'Business Registration Certificate',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color:
                        isDarkMode ? AppColors.borderColor2 : Color(0xff333333),
                  ),
                ),
                SizedBox(height: 16),
                PhotoUploadWidget(),
                SizedBox(height: 24),
                Text(
                  'Short Bio',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color:
                        isDarkMode ? AppColors.borderColor2 : Color(0xff333333),
                  ),
                ),
                SizedBox(height: 16),
                _buildTextField('Bio', 'Bio', 2),
                SizedBox(height: 48),
                // Get Verified Button
                GestureDetector(
                  onTap: () {
                    Get.to(
                      VThankYouScreen(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 400),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xff003366),
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
                SizedBox(height: 16),
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
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return TextField(
      style: getTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: isDarkMode ? Color(0xffA1A1A1) : Color(0xff333333),
      ),
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? Color(0xffA1A1A1) : Color(0xff767676),
        ),
        hintText: hintText,
        hintStyle: getTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: isDarkMode ? Color(0xffA1A1A1) : Color(0xff767676),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode ? Color(0xffAFB1B6) : Color(0xffABB7C2),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode ? Color(0xffAFB1B6) : Color(0xffABB7C2),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode ? Color(0xffAFB1B6) : Color(0xffABB7C2),
            width: 1,
          ),
        ),
      ),
    );
  }
}
