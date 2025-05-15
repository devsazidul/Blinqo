import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/services/stripe_payment_service.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/screens/v_congratulation_screen.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/widgets/v_payment_app_bar.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class VPaymentMethod extends StatelessWidget {
  const VPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xff151515) : Color(0xffF9FAFB),
      appBar: VPaymentAppBar(title: 'Payment Option'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 60),
              Image.asset(ImagePath.nopaymentfound, height: 250),
              Text(
                'No Payment Method Found',
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Color(0xffEBEBEB) : Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'You can add or edit payment during checkout',
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? Color(0xffA1A1A1) : Color(0xff5F5F5F),
                ),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  _stripPayment();
                  // Get.to(
                  //   VPaymentOptionScreen(),
                  //   transition: Transition.rightToLeft,
                  //   duration: const Duration(milliseconds: 400),
                  // );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Color(0xff32383D) : Color(0xffFEFEFE),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isDarkMode ? Color(0xff32383D) : Color(0xffE4E4E7),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: Image.asset(
                        IconPath.paymentaddicone,
                        width: 44,
                        height: 44,
                      ),
                      title: Text('Add a payment method'),
                      titleTextStyle: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:
                            isDarkMode ? Color(0xffEBEBEB) : Color(0xff171725),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Stripe Payment Method
void _stripPayment() async {
  try {
    final isSuccess = await StripePaymentService.payWithStripe(
      body: PaymentService(
        currency: "usd",
        email: EventAuthController.userInfo?.email,
        amount: 10,
        // id: "",
        userId: EventAuthController.profileInfo?.profile?.id,
        paymentType: PaymentType.verificationFee,
      ),
      merchantDisplayName: "Md Razib",
    );
    if (isSuccess) {
      Get.to(() => VCongratulationScreen());
    }
  } catch (e) {
    EasyLoading.showError('Failed to make payment: $e');
  }
}
