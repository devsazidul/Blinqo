import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/ep_common/widgets/ep_bottom_nav_bar_widget.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/ep_payment_controller/ep_payment_option_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/ep_paymant_screen/ep_payment_option_card.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpPaymentOption extends StatelessWidget {
  EpPaymentOption({super.key});
  final EpPaymentOptionController spPaymentOptionController = Get.put(
    EpPaymentOptionController(),
  );
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
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
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
          'Payment Option',
          style: getTextStyle(
            fontSize: 20,
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
            SizedBox(height: 60),
            Column(
              children: [
                Image.asset(
                  IconPath.paymentempty,
                  width: double.infinity,
                  height: 195,
                ),
                SizedBox(height: 20),
                Text(
                  "No Payment Method Found!",
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColors.primary : AppColors.textColor,
                    lineHeight: 2,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "You can add or edit payment during checkout",
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? AppColors.primary : AppColors.textColor,
                    lineHeight: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            SizedBox(height: 40),
            GestureDetector(
              onTap: () async {
                Get.to(EpPaymentOptionCard());
                spPaymentOptionController.makePayment();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 64,
                decoration: BoxDecoration(
                  color:
                      isDarkMode
                          ? AppColors.textFieldDarkColor
                          : AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(IconPath.paymentaddcircle),
                    ),
                    SizedBox(width: 14),
                    Text(
                      'Add a new payment method',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:
                            isDarkMode
                                ? AppColors.primary
                                : AppColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: EpBottomNavBarWidget(),
    );
  }
}
