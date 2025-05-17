import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_continue_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart' show IconPath;
import 'package:blinqo/features/role/service_provider/payment_page/controller/sp_payment_option_controller.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_verification_thanks.dart';
import 'package:blinqo/features/role/service_provider/payment_page/widget/sp_custom_payment_card.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpPaymentOptionCard extends StatelessWidget {
  SpPaymentOptionCard({super.key});

  final SpPaymentOptionController spPaymentOptionController = Get.put(
    SpPaymentOptionController(),
  );
  final controller = Get.put(SpProfileController());

  @override
  Widget build(BuildContext context) {
    spPaymentOptionController.initializeSelectedCards(5);
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
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
                    themeMode == ThemeMode.dark
                        ? AppColors.primary.withValues(alpha: .10)
                        : AppColors.appBarIcolor,
                child: Image.asset(
                  IconPath.arrowleft,
                  width: 20,
                  height: 20,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.primary
                          : AppColors.textColor,
                ),
              ),
            ),
          ),
          title: Text(
            'Payment Option',
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 60),
              Column(
                children: [
                  SpCustomPaymentCard(
                    spPaymentOptionController: spPaymentOptionController,
                    cardName: 'Master Card',
                    cardImagePath: IconPath.mastercard,
                    cardIndex: 0,
                  ),
                  SizedBox(height: 12),
                  SpCustomPaymentCard(
                    spPaymentOptionController: spPaymentOptionController,
                    cardName: 'Debit Card',
                    cardImagePath: IconPath.carddebit,
                    cardIndex: 1,
                  ),
                  SizedBox(height: 12),
                  SpCustomPaymentCard(
                    spPaymentOptionController: spPaymentOptionController,
                    cardName: 'Visa Card',
                    cardImagePath: IconPath.cardvisa,
                    cardIndex: 2,
                  ),
                  SizedBox(height: 12),
                  SpCustomPaymentCard(
                    spPaymentOptionController: spPaymentOptionController,
                    cardName: 'PayPal',
                    cardImagePath: IconPath.cardpaypal,
                    cardIndex: 3,
                  ),
                  SizedBox(height: 12),
                  SpCustomPaymentCard(
                    spPaymentOptionController: spPaymentOptionController,
                    cardName: 'Klarna',
                    cardImagePath: IconPath.cardklarna,
                    cardIndex: 4,
                  ),
                ],
              ),
              SizedBox(height: 48),
              CustomContinueButton(
                onPress: () {
                  Get.to(SpVerificationThanks());
                },
                title: "Confirm & Pay",
              ),
            ],
          ),
        ),
      );
    });
  }
}
