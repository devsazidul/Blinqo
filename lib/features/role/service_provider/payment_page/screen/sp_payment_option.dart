import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_appbar_widget.dart';
import 'package:blinqo/core/services/stripe_payment_service.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/payment_page/controller/sp_payment_option_controller.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_congratulations_page.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpPaymentOption extends StatelessWidget {
  const SpPaymentOption({super.key});
  @override
  Widget build(BuildContext context) {
    final spPaymentOptionController = Get.put(SpPaymentOptionController());
    final profileController = Get.find<SpProfileController>();
    return Obx(() {
      return Scaffold(
        backgroundColor:
            profileController.isDarkMode.value
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
        appBar: CustomAppBarWidget(title: "Payment Option"),

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
                      color:
                          profileController.isDarkMode.value
                              ? AppColors.primary
                              : AppColors.textColor,
                      lineHeight: 2,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "You can add or edit payment during checkout",
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color:
                          profileController.isDarkMode.value
                              ? AppColors.primary
                              : AppColors.textColor,
                      lineHeight: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              SizedBox(height: 40),
              GestureDetector(
                onTap:
                    () => _onClickAddPaymentMethod(spPaymentOptionController),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 64,
                  decoration: BoxDecoration(
                    color:
                        profileController.isDarkMode.value
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
                              profileController.isDarkMode.value
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
      );
    });
  }

  void _onClickAddPaymentMethod(
    SpPaymentOptionController spPaymentOptionController,
  ) async {
    final isSuccess = await StripePaymentService.payWithStripe(
      body: PaymentService(
        currency: "usd",
        email: SpAuthController.spUser?.email,
        amount: 10,
        // id: "123",
        userId: SpAuthController.spUser?.id,
        paymentType: PaymentType.verificationFee,
      ),
      merchantDisplayName: "Mukarrom",
    );
    if (isSuccess) {
      Get.to(() => SpCongratulationsPage());
    }
  }
}
