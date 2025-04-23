import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/gif_path.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/widgets/v_payment_app_bar.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VCongratulationScreen extends StatelessWidget {
  const VCongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xff000000) : Color(0xffFFFFFF),
      appBar: VPaymentAppBar(
        isBackButtonVisible: false,
        title: 'Congratulations',
        isCloseButtonVisible: true,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                isDarkMode ? GifPath.successdark : GifPath.successlight,
                height: height * 0.4,
                fit: BoxFit.cover,
              ),
              Container(
                width: width,
                height: height * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      isDarkMode
                          ? Color(0x00000000)
                          : Color(0xffFFFFFF).withValues(alpha: 0.1),
                      isDarkMode
                          ? Color(0x00000000)
                          : Color(0xffFFFFFF).withValues(alpha: 0.1),
                      isDarkMode
                          ? Color(0x00000000)
                          : Color(0xffFFFFFF).withValues(alpha: 0.1),
                      isDarkMode
                          ? Color(0xff000000)
                          : Color(0xffFFFFFF).withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: isDarkMode ? Color(0xff32383D) : Color(0xffF9FAFB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You’re Verified',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your profile now includes a trust badge and will appear higher in searches.',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: isDarkMode ? Color(0xffC0C0C0) : Color(0xff333333),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
