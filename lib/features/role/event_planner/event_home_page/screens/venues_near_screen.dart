import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/featured_venues.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenuesNearScreen extends StatelessWidget {
  const VenuesNearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final ProfileController profileController = Get.find<ProfileController>();
    Get.put(FavoriteController);
    return Obx(() {
      final themeMode =
          profileController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? Colors.black
                : AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          forceMaterialTransparency: true,
          leading: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: CircleAvatar(
                backgroundColor:
                    themeMode == ThemeMode.dark
                        ? AppColors.darkBackgroundColor
                        : const Color(0xFFD9D9D9),
                child: Image.asset(
                  IconPath.arrowLeftAlt,

                  width: 18,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.backgroundColor
                          : AppColors.textColor,
                ),
              ),
            ),
          ),
          title: Text(
            'Venues Near You',
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.backgroundColor
                      : AppColors.textColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 3,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: _buildChildAspectRatio(screenWidth),
            ),
            itemBuilder: (context, index) {
              return FeaturedVenuesCard(index: index, hasButton: false);
            },
          ),
        ),
      );
    });
  }

  _buildChildAspectRatio(double screenWidth) {
    if (screenWidth <= 360) {
      return 0.703;
    }
    if (screenWidth >= 360 && screenWidth < 448) {
      return 0.735;
    } else {
      return 0.77;
    }
  }
}
