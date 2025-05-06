import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/sp_profile_setup_controller.dart';
import 'package:blinqo/features/role_page/controller/role_controller.dart';
import 'package:blinqo/features/role_page/widget/rolecustomcontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RoleController roleController = Get.put(RoleController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Select Your Role",
                style: getTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Choose a role to get started",
                textAlign: TextAlign.left,
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  RoleCustomContainer(
                    imagePath: IconPath.frame0,
                    title: "Event Planner 🎉",
                    index: 0,
                  ),
                  SizedBox(height: 8),
                  RoleCustomContainer(
                    imagePath: IconPath.frame1,
                    title: "Venue Owner 🏢",
                    index: 1,
                  ),
                  SizedBox(height: 8),
                  RoleCustomContainer(
                    imagePath: IconPath.frame2,
                    title: "Service Provider 🎭",
                    index: 2,
                  ),
                ],
              ),
              SizedBox(height: 48),
              GestureDetector(
                onTap: () async {
                  await SpAuthController.getUserInformation();
                  if (SpAuthController.token != null &&
                      roleController.selectedIndex.value == 2) {
                    Get.put(SpProfileSetupController()).getEventPreferences();
                  }

                  debugPrint(
                    "Selected Role Index: ${roleController.selectedIndex.value}",
                  );
                  roleController.navigateToRolePage();
                },
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor2,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
