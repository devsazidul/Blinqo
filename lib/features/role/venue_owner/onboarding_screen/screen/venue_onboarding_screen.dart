import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/venue_owner/bottom_nav_bar/screen/vanueOwner_bottom_nav_bar.dart';
import 'package:blinqo/features/role/venue_owner/onboarding_screen/controller/v_onboring_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueOnboardingScreen extends StatelessWidget {
  const VenueOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.put(OnboardingController());

    // Get screen size for responsive scaling
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Define responsive scaling factors
    final double imageHeight = screenHeight * 0.47; // 35% of screen height
    final double titleFontSize = screenWidth * 0.07; // Scales with screen width
    final double subtitleFontSize = screenWidth * 0.04;
    final double padding = screenWidth * 0.05; // 5% of screen width
    final double buttonHeight = screenHeight * 0.06; // 7% of screen height

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background with gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00000000), Color(0xff031A30)],
                ),
              ),
            ),
            // Page content
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    itemCount: controller.pages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: padding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image
                            SizedBox(height: padding * 3),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                return Image.asset(
                                  controller.pages[index]['image']!,
                                  height: imageHeight,
                                  fit: BoxFit.contain,
                                );
                              },
                            ),
                            SizedBox(height: padding * 0.4),
                            // Title
                            Text(
                              controller.pages[index]['title']!,
                              style: getTextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffF6F6F6),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: padding * 0.5),
                            // Subtitle
                            Text(
                              controller.pages[index]['subtitle']!,
                              style: TextStyle(
                                fontSize: subtitleFontSize,
                                color: Color(0xffC8C8C8),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Page Indicator
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: padding / 5),
                        width: controller.currentPage.value == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color:
                              controller.currentPage.value == index
                                  ? const Color(0xffD4AF37)
                                  : Color(0xffC0C0C0),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: padding * 1.1),
                // Next Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: () {
                        if (controller.currentPage.value ==
                            controller.pages.length - 1) {
                          // Navigate to the home page
                          Get.off(VanueOwnerBottomNavBar());
                        } else {
                          controller.nextPage();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffD4AF37),
                        minimumSize: Size(double.infinity, buttonHeight),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        controller.currentPage.value ==
                                controller.pages.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style: getTextStyle(
                          fontSize: subtitleFontSize * 1.2,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: padding * 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
