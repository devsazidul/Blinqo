import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_login_screen.dart';
import 'package:blinqo/features/splasho_screen/screen/splasho_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VOnboardingScreen extends StatelessWidget {
  final PageController pageController = PageController();
  final PageControllerController controller = Get.put(
    PageControllerController(),
  );

  VOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double bottomHeight = (screenHeight < 700) ? 10 : 32;
    double slideHeight = (screenHeight < 700) ? 75 : 110;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x00000000), Color(0xFF031A30)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              PageView(
                controller: pageController,
                onPageChanged: (index) {
                  controller.changePage(index);
                  if (index == 3) {
                    Future.delayed(Duration(milliseconds: 1000), () {
                      Get.to(
                        SplashoScreen(),
                        transition: Transition.rightToLeft,
                        duration: Duration(seconds: 1),
                      );
                    });
                  }
                },
                children: [Page1(), Page2(), Page3()],
              ),

              Positioned(
                bottom: slideHeight,
                left: MediaQuery.of(context).size.width * 0.40,
                child: Obx(() {
                  return Row(
                    children: List.generate(
                      3,
                      (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 8,
                        width: controller.currentPage.value == index ? 25 : 8,
                        decoration: BoxDecoration(
                          color:
                              controller.currentPage.value == index
                                  ? AppColors.buttonColor
                                  : Color(0xFFC0C0C0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              Positioned(
                bottom: bottomHeight,
                left: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    if (controller.currentPage.value < 2) {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Get.to(VLoginScreen());
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    decoration: BoxDecoration(
                      color: AppColors.buttonColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Next",
                        style: getTextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
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

class PageControllerController extends GetxController {
  var currentPage = 0.obs;
  var isOnLastPage = false.obs;

  void changePage(int index) {
    currentPage.value = index;
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double scaledHeight = (screenHeight < 700) ? 0 : 0;
    double imageHeight = (screenHeight < 700) ? 430 : 610;
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(
              ImagePath.venueonboarding01,
              width: double.infinity,
              height: imageHeight,
            ),
            Positioned(
              bottom: scaledHeight,
              left: 30,
              child: Column(
                children: [
                  Text(
                    'List Your Venue in \n Minutes',
                    style: getTextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Showcase your event space with images,',
                    style: getTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'amenities, and pricing to attract customers.',
                    style: getTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double scaledHeight = (screenHeight < 700) ? 0 : 0;
    double imageHeight = (screenHeight < 700) ? 430 : 610;
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(
              ImagePath.venueonboarding02,
              width: double.infinity,
              height: imageHeight,
            ),
            Positioned(
              bottom: scaledHeight,
              left: 30,
              child: Column(
                children: [
                  Text(
                    'Real-Time Booking &',
                    style: getTextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Availability',
                    style: getTextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),

                  Text(
                    'Accept or decline bookings, update availability,',
                    style: getTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'and manage reservations easily.',
                    style: getTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double scaledHeight = (screenHeight < 700) ? 0 : 0;
    double imageHeight = (screenHeight < 700) ? 430 : 610;

    return Column(
      children: [
        Stack(
          children: [
            Image.asset(
              ImagePath.venueonboarding03,
              width: double.infinity,
              height: imageHeight,
            ),
            Positioned(
              bottom: scaledHeight,
              left: 30,
              child: Column(
                children: [
                  Text(
                    'Boost Your Venue’s',
                    style: getTextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Visibility',
                    style: getTextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),

                  Text(
                    'Get featured, collect reviews, and increase',
                    style: getTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'revenue with premium listings and insights.',
                    style: getTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
