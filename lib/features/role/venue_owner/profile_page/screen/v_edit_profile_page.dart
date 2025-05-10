import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venu_profile_setup_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/v_profile_app_bar.dart';
import 'package:blinqo/features/role/venue_owner/widgets/event_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VEditProfilePage extends StatelessWidget {
  static const String name = '/v_edit_profile_page';

  final bool isEditProfile;

  const VEditProfilePage({super.key, this.isEditProfile = false});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final VenueProfileSetupController profileSetupController = Get.put(VenueProfileSetupController());

    // Initialize fields for edit mode
    if (isEditProfile) {
      profileSetupController.getUserInfo();
    } else {
      profileSetupController.clear();
    }

    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkBackgroundColor : AppColors.backgroundColor,
      appBar: VProfileAppBar(title: isEditProfile ? 'Edit Profile' : 'Set Up Profile'),
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDarkMode ? Colors.white30 : Colors.grey[300]!,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: const Color(0xffD9D9D9),
                                child: profileSetupController.profileImage.value != null
                                    ? ClipOval(
                                  child: Image.file(
                                    profileSetupController.profileImage.value!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                                    : isEditProfile &&
                                    EventAuthController.profileInfo?.profile?.image?.path != null
                                    ? ClipOval(
                                  child: Image.network(
                                    EventAuthController.profileInfo!.profile!.image!.path,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                                    : const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: profileSetupController.isLoading.value
                                    ? null
                                    : () => profileSetupController.pickImage(),
                                child: CircleAvatar(
                                  backgroundColor: const Color(0xffD4AF37),
                                  radius: 16,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 18,
                                    color: const Color(0xff003366),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            TextFieldWidget(
                              hintText: 'Enter your Name',
                              labelText: 'Name',
                              controller: profileSetupController.nameTEController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFieldWidget(
                              hintText: 'Enter your location',
                              labelText: 'Location',
                              controller: profileSetupController.locationTEController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your location';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: profileSetupController.isLoading.value
                              ? null
                              : () {
                            if (formKey.currentState!.validate()) {
                              if (isEditProfile) {
                                profileSetupController.updateProfile();
                              } else {
                                profileSetupController.submitProfile();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                            backgroundColor: const Color(0xff003366),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: profileSetupController.isLoading.value
                              ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                              : Text(
                            isEditProfile ? 'Update Profile' : 'Save & Continue',
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}