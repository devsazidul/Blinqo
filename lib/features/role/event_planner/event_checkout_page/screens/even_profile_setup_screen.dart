import 'package:blinqo/core/common/widgets/upgrade_to_pro.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../service_provider/payment_page/screen/get_verified_screen.dart';
import '../../../service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'controllers/even_profile_controller.dart';
import 'profile_setup_widget/avater_profile_setup_screen.dart';
import 'profile_setup_widget/even_planner_gender.dart';
import 'profile_setup_widget/event_preference_card.dart';
import 'profile_setup_widget/profile_setup_button.dart';
import 'profile_setup_widget/profile_setup_google_map.dart';

class EvenProfileSetupScreen extends StatelessWidget {
  EvenProfileSetupScreen({super.key});
  final EvenProfileController controller = Get.put(EvenProfileController());
  // final MyController myController = Get.put(MyController());
  final spProfileController = Get.find<SpProfileController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Get the current theme mode (light or dark)
      final themeMode =
          spProfileController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,

        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Your existing profile sections
                  AvaterProfileSetupScreen(themeMode: themeMode),
                  const SizedBox(height: 20),
                  EvenPlannerGender(),
                  const SizedBox(height: 20),
                  ProfileSetupGoogleMap(themeMode: themeMode),
                  const SizedBox(height: 20),

                  // Event Preferences Grid
                  EventPreferenceCard(
                    evenProfileController: controller,
                    themeMode: themeMode,
                  ),

                  SizedBox(height: 40),
                  UpgradeToProcard(onTap: () {}),
                  SizedBox(height: 40),
                  ProfileSetupButton(
                    onTap: () {
                      Get.to(GetVerifiedScreen());
                    },
                    title: "Continue",
                    themeMode: themeMode,
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
