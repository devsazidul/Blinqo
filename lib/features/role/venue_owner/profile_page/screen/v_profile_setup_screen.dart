import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/screens/v_get_verified_screen.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venu_profile_setup_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/screen/venue_setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueProfileScreen extends StatelessWidget {
  const VenueProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VenueOwnerProfileController controller = Get.put(
      VenueOwnerProfileController(),
    );
    final VenueProfileSetupController profileSetupController = Get.put(
      VenueProfileSetupController(),
    );
    final bool isDarkMode = controller.isDarkMode.value;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Profile Setup',
                    style: getTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Stack(
                  children: [
                    Center(
                      child: Obx(
                        () => CircleAvatar(
                          radius: 48,
                          backgroundColor: Color(0xffD9D9D9),
                          backgroundImage:
                              profileSetupController.profileImage.value != null
                                  ? FileImage(
                                    profileSetupController.profileImage.value!,
                                  )
                                  : null,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 65,
                      left: 195,
                      child: GestureDetector(
                        onTap: () => profileSetupController.pickImage(),
                        child: CircleAvatar(
                          backgroundColor: Color(0xffD4AF37),
                          radius: 14,
                          child: Icon(
                            Icons.mode_edit_outline_outlined,
                            size: 16,
                            color: Color(0xff003366),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      _buildTextField(
                        hintText: 'Enter your Username',
                        labelText: 'Username',
                        controller: profileSetupController.nameController,
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          } if(value.length < 3) {
                            return 'Username must be at least 3 characters';
                          } if(value.length > 15) {
                            return 'Username must be less than 15 characters';
                          } if(!RegExp(r'^[a-z0-9_]+$').hasMatch(value)) {
                            return 'Username can only contain lowercase letters, numbers, and underscores';
                          }
                          return null;
                        }
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        hintText: 'Enter your location',
                        labelText: 'Location',
                        controller: profileSetupController.locationController,
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Please enter your location';
                          }
                          return null;
                        }
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff000000), Color(0xff003285)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upgrade to pro',
                        style: getTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Boost Your Visibility & Get More Bookings with Premium!',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => Get.off(VGetVerifiedScreen()),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          backgroundColor: Color(0xffD4AF37),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Upgrade Now',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // profileSetupController.submitProfile();
                        Get.to(VenueSetupScreen());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      backgroundColor: Color(0xff003366),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required String labelText,
    String? Function(String?)? validator,
    required TextEditingController controller,
  }) {
    final VenueOwnerProfileController profileController = Get.put(
      VenueOwnerProfileController(),
    );
    final bool isDarkMode = profileController.isDarkMode.value;
    return TextFormField(
      controller: controller,
      validator: validator,
      style: getTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? Color(0xffC0C0C0) : Color(0xff767676),
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
