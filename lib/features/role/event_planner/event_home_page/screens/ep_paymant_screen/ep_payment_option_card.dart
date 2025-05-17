import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_continue_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart' show IconPath;
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/ep_payment_controller/ep_payment_option_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/ep_paymant_screen/ep_congratulations_page.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/ep_payment_widget/ep_custom_payment_card.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpPaymentOptionCard extends StatelessWidget {
  EpPaymentOptionCard({super.key});

  final EpPaymentOptionController epPaymentOptionController = Get.put(
    EpPaymentOptionController(),
  );
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    epPaymentOptionController.initializeSelectedCards(5);
    bool isDarkMode = controller.isDarkMode.value;
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
                EpCustomPaymentCard(
                  epPaymentOptionController: epPaymentOptionController,
                  cardName: 'Master Card',
                  cardImagePath: IconPath.mastercard,
                  cardIndex: 0,
                ),
                SizedBox(height: 12),
                EpCustomPaymentCard(
                  epPaymentOptionController: epPaymentOptionController,
                  cardName: 'Debit Card',
                  cardImagePath: IconPath.carddebit,
                  cardIndex: 1,
                ),
                SizedBox(height: 12),
                EpCustomPaymentCard(
                  epPaymentOptionController: epPaymentOptionController,
                  cardName: 'Visa Card',
                  cardImagePath: IconPath.cardvisa,
                  cardIndex: 2,
                ),
                SizedBox(height: 12),
                EpCustomPaymentCard(
                  epPaymentOptionController: epPaymentOptionController,
                  cardName: 'PayPal',
                  cardImagePath: IconPath.cardpaypal,
                  cardIndex: 3,
                ),
                SizedBox(height: 12),
                EpCustomPaymentCard(
                  epPaymentOptionController: epPaymentOptionController,
                  cardName: 'Klarna',
                  cardImagePath: IconPath.cardklarna,
                  cardIndex: 4,
                ),
              ],
            ),
            SizedBox(height: 48),
            CustomContinueButton(
              onPress: () {
                Get.to(EpCongratulationsPage());
              },
              title: "Confirm & Pay",
            ),
          ],
        ),
      ),
    );
  }
}
