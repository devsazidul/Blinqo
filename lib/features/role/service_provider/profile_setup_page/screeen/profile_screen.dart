import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/profile_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/widget/customcircleavater.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.borderColor,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.borderColor,
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Obx(
                  () => Container(
                    width: double.infinity,
                    height: 61,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                                  (value) =>
                                      profileController.updateRoles(value),
                              itemBuilder: (context) {
                                return profileController.roles.map((role) {
                                  return PopupMenuItem<String>(
                                    value: role,
                                    child: Text(role),
                                  );
                                }).toList();
                              },
                              padding: EdgeInsets.zero,
                              offset: Offset(0, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    profileController.selectedRoles.value,
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
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Event Preference",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCircleAvater(
                      imagePath: IconPath.corporateEvents,
                      text: "Corporate",
                    ),
                    SizedBox(height: 8),
                    CustomCircleAvater(
                      imagePath: IconPath.wedding,
                      text: "Weddings",
                    ),
                    SizedBox(height: 8),
                    CustomCircleAvater(
                      imagePath: IconPath.musidFastivals,
                      text: "Music Festivals",
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCircleAvater(
                      imagePath: IconPath.corporateEvents,
                      text: "Corporate",
                    ),
                    SizedBox(height: 8),
                    CustomCircleAvater(
                      imagePath: IconPath.wedding,
                      text: "Weddings",
                    ),
                    SizedBox(height: 8),
                    CustomCircleAvater(
                      imagePath: IconPath.musidFastivals,
                      text: "Music Festivals",
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCircleAvater(
                      imagePath: IconPath.corporateEvents,
                      text: "Corporate",
                    ),
                    SizedBox(height: 8),
                    CustomCircleAvater(
                      imagePath: IconPath.wedding,
                      text: "Weddings",
                    ),
                    SizedBox(height: 8),
                    CustomCircleAvater(
                      imagePath: IconPath.musidFastivals,
                      text: "Music Festivals",
                    ),
                  ],
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
