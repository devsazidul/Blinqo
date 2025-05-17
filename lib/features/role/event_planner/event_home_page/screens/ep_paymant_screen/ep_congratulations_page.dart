import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/gif_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/service_provider/ep_service_provider_booking_screen3.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpCongratulationsPage extends StatelessWidget {
  EpCongratulationsPage({super.key});
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = controller.isDarkMode.value;
    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Congratulations',
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.primary : AppColors.textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                isDarkMode ? GifPath.successdark : GifPath.successlight,
                width: double.infinity,
                height: 270,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 20),
            Text(
              "You have completed\n your booking",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColors.primary : Colors.black,
              ),
            ),
            SizedBox(height: 40),
            CustomButton(
              title: "Booking Details",
              onPress: () {
                Get.to(EpServiceProviderBookingScreen3());
              },
            ),
          ],
        ),
      ),
    );
  }
}
