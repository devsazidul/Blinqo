import 'package:blinqo/core/common/widgets/upgrade_to_pro.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/bottom_nav_bar/screen/event_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    final femaleColorController = Get.find<PickColorController>();
    final bool isFemale = femaleColorController.isFemale.value;
    return Obx(() {
      // Get the current theme mode (light or dark)
      final themeMode =
          profileController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

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
                      Get.to(EventBottomNavBar());
                    },
                    title: "Continue",
                    isFemale: isFemale,
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
