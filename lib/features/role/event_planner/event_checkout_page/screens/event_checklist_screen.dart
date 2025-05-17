import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/controllers/checklist_controller.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/build_checkappbar.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/create_checklist_screen.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EventChecklistScreen extends StatelessWidget {
  const EventChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // print("hello");
    // final ChecklistController controller = Get.put(ChecklistController());
    final profileController = Get.find<ProfileController>();
    final femaleColorController = Get.find<PickColorController>();
    final bool isFemale = femaleColorController.isFemale.value;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Get.put(ChecklistController());

    return Obx(() {
      final themeMode =
          profileController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.borderColor2,
        appBar: buildCheckVenueAppBar(),

        body: Center(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.08),
              SvgPicture.asset(
                ImagePath.nochecklist,
                height: screenHeight * 0.3,
              ),
              SizedBox(height: screenHeight * 0.010),
              Text(
                'Nothing Found!',
                style: getTextStyle(
                  fontSize: screenWidth > 600 ? 20 : 16,
                  fontWeight: FontWeight.w600,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.borderColor2
                          : AppColors.textColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.010),
              Text(
                "You didn't added any task yet",
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.borderColor2
                          : AppColors.subTextColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              OutlinedButton(
                onPressed: () {
                  Get.offAll(const CreateChecklistScreen());
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: screenWidth > 600 ? 12 : 9,
                    horizontal: screenWidth > 600 ? 20 : 12,
                  ),
                  fixedSize: Size(screenWidth * 0.4, 44),
                  side: BorderSide(
                    color:
                        themeMode == ThemeMode.dark
                            ? AppColors.buttonColor
                            : isFemale
                            ? femaleColorController.selectedColor
                            : AppColors.iconColor,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add Task',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.buttonColor
                                : isFemale
                                ? femaleColorController.selectedColor
                                : AppColors.iconColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.add_circle_outline_outlined,
                      size: 24,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.buttonColor
                              : isFemale
                              ? femaleColorController.selectedColor
                              : AppColors.iconColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
