import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/screen/ep_Chat_Screen.dart';
import 'package:blinqo/features/role/event_planner/common/widgets/ep_bottom_nav_bar_widget.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/ep_service_provider_controller/ep_service_provider_booking_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/ep_paymant_screen/ep_payment_option.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_indicator_package/step_indicator.dart';

class EpServiceProviderBookingScreen3 extends StatelessWidget {
  final EpServiceProviderBookingController controller = Get.put(
    EpServiceProviderBookingController(),
  );

  EpServiceProviderBookingScreen3({super.key});
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = profileController.isDarkMode.value;
    final myController = StepIndicatorController(maxSteps: 3);
    Future.delayed(Duration(milliseconds: 400), () {
      myController.setStep(2);
    });
    final double totalCost = 8000;
    final double payableAmount = 800;
    final double dueAmount = 7200;
    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor:
                  isDarkMode
                      ? AppColors.primary.withValues(alpha: .10)
                      : AppColors.appBarIcolor,
              child: Image.asset(
                IconPath.arrowleft,
                width: 20,
                height: 20,
                color: isDarkMode ? AppColors.primary : AppColors.textColor,
              ),
            ),
          ),
        ),
        title: Text(
          'Booking',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.primary : AppColors.textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  IconPath.projectrequestimage,
                  width: 125,
                  height: 125,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Ronald Richards',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? AppColors.primary : AppColors.buttonColor2,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  IconPath.projectrequestlocation,
                  width: 16,
                  height: 16,
                  fit: BoxFit.cover,
                  color:
                      isDarkMode ? AppColors.primary : AppColors.subTextColor,
                ),
                SizedBox(width: 10),
                Text(
                  'Radio Colony, Savar',
                  style: getTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color:
                        isDarkMode ? AppColors.primary : AppColors.subTextColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '4.5',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color:
                        isDarkMode ? AppColors.primary : AppColors.subTextColor,
                  ),
                ),
                SizedBox(width: 4),
                Image.asset(
                  IconPath.ratinglogo,
                  width: 11,
                  height: 12,
                  color:
                      isDarkMode ? AppColors.primary : AppColors.subTextColor,
                ),
                SizedBox(width: 30),
                Text(
                  'Project - 10',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color:
                        isDarkMode ? AppColors.primary : AppColors.subTextColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor:
                    isDarkMode ? AppColors.buttonColor : AppColors.buttonColor2,
                backgroundColor:
                    isDarkMode
                        ? AppColors.buttonColor.withValues(alpha: .10)
                        : AppColors.chatBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Get.to(() => EpChatScreen());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    IconPath.messageicon,
                    width: 20,
                    height: 20,
                    color:
                        isDarkMode
                            ? AppColors.buttonColor
                            : AppColors.buttonColor2,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Message",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color:
                          isDarkMode
                              ? AppColors.buttonColor
                              : AppColors.buttonColor2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Booking Timeline',
              style: getTextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color:
                    isDarkMode ? AppColors.buttonColor : AppColors.buttonColor2,
              ),
            ),
            SizedBox(height: 10),

            // STEP INDICATOR
            StepIndicator(
              controller: myController,
              allowCircleTap: false,
              circleRadius: 18,
              paddingHorizontal: 60,
              showNavigationButtons: false,
              activeLineColor:
                  isDarkMode ? AppColors.buttonColor : AppColors.buttonColor2,
              activeColor:
                  isDarkMode ? AppColors.buttonColor : AppColors.buttonColor2,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Center(
                child: Text(
                  controller.eventName.value,
                  style: getTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color:
                        isDarkMode ? AppColors.primary : AppColors.buttonColor2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    isDarkMode
                        ? AppColors.textFieldDarkColor
                        : AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Booking",
                    style: getTextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color:
                          isDarkMode
                              ? AppColors.buttonColor
                              : AppColors.buttonColor2,
                    ),
                  ),
                  SizedBox(height: 10),
                  EventInfoTile(
                    title: 'Organizer',
                    value: controller.eventPlannerName.value,
                  ),
                  EventInfoTile(title: 'Venue', value: controller.venue.value),
                  EventInfoTile(
                    title: 'Location',
                    value: controller.location.value,
                  ),
                  EventInfoTile(
                    title: 'Date',
                    value: controller.selectedDate.value?.toString() ?? 'N/A',
                  ),
                  EventInfoTile(
                    title: 'Time',
                    value:
                        '${controller.startTime.value.format(context)} - ${controller.endTime.value.format(context)}',
                  ),
                  EventInfoTile(
                    title: 'Guest',
                    value: controller.numberOfGuests.value,
                  ),
                  EventInfoTile(
                    title: 'Event Type',
                    value: controller.eventType.value,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // PRICE DETAILS
            Obx(() {
              return controller.showPriceDetails.value
                  ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              isDarkMode
                                  ? AppColors.textFieldDarkColor
                                  : AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price Details',
                              style: getTextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color:
                                    isDarkMode
                                        ? AppColors.buttonColor
                                        : AppColors.buttonColor2,
                              ),
                            ),
                            SizedBox(height: 10),
                            EventInfoTile(
                              title: 'Total Cost',
                              value: '\$$totalCost',
                            ),
                            SizedBox(height: 10),
                            EventInfoTile(
                              title: 'Payable Amount',
                              value: '\$$payableAmount',
                            ),
                            SizedBox(height: 10),
                            EventInfoTile(title: 'Due', value: '\$$dueAmount'),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  )
                  : SizedBox();
            }),
            SizedBox(height: 20),

            CustomButton(
              title: "Next Payment",
              onPress: () {
                Get.to(EpPaymentOption());
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: EpBottomNavBarWidget(),
    );
  }

  Widget detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[700])),
          Text(value, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class EventInfoTile extends StatelessWidget {
  final String title;
  final String value;

  EventInfoTile({super.key, required this.title, required this.value});
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = profileController.isDarkMode.value;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getTextStyle(
              color: AppColors.subTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: getTextStyle(
              color: isDarkMode ? AppColors.primary : AppColors.textColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
