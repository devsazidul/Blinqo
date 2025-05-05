import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/sp_profile_setup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final SpProfileSetupController profileController = Get.put(
    SpProfileSetupController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Profile Setup",
                    style: getTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Obx(() {
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      child: ClipOval(
                        child:
                            profileController.profileImage.value == null
                                ? Image.asset(
                                  IconPath.profile01,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                                : Image.file(
                                  profileController.profileImage.value!,
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
                          debugPrint("Edit Profile Picture");
                          profileController.pickImage();
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
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter your name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
