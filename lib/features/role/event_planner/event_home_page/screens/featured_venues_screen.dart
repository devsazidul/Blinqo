import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/feature_venue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeaturedVenuesScreen extends StatelessWidget {
  const FeaturedVenuesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final ProfileController profileController = Get.find<ProfileController>();

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
                backgroundColor: AppColors.textColor.withValues(alpha: 0.15),
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.arrow_back,
                    color:
                        themeMode == ThemeMode.dark
                            ? AppColors.primary
                            : AppColors.textColor,
                  ),

                  onPressed: () => Get.back(),
                ),
              ),
            ),
          ),
          title: Text(
            'Featured Venues',
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.primary
                      : AppColors.textColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: _buildChildAspectRatio(screenWidth),
            ),
            itemBuilder: (context, index) {
              return FeatureVenues(hasButton: false, index: index);
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
