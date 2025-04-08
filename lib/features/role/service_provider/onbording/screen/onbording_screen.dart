import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_login_screen.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/bottom_nav_bar.dart';
import 'package:blinqo/features/splasho_screen/screen/splasho_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnbordingScreen extends StatelessWidget {
  final PageController pageController = PageController();
  final PageControllerController controller = Get.put(
    PageControllerController(),
  );
  OnbordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 40),
              Positioned(
                bottom: 100,
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
                bottom: 32,
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
                      Get.to(SpLoginScreen());
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
    double imagehight = (screenHeight < 700) ? 300 : 485;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          // width: 236, height: 485
          Image.asset(
            ImagePath.serviceprovider01,
            width: 236,
            height: imagehight,
          ),
          Text(
            'Get noticed by local\n event organizers.',
            style: getTextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),

          Text(
            'Showcase your services and reach clients',
            style: getTextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'looking for your expertise.',
            style: getTextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double imagehight = (screenHeight < 700) ? 300 : 485;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Image.asset(
            ImagePath.serviceprovider02,
            width: 236,
            height: imagehight,
          ),
          Text(
            'Secure bookings with easy payments.',
            style: getTextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),

          Text(
            'Receive direct booking requests and manage ',
            style: getTextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'payments seamlessly.',
            style: getTextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double imagehight = (screenHeight < 700) ? 300 : 485;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Image.asset(
            ImagePath.serviceprovider03,
            width: 236,
            height: imagehight,
          ),
          Text(
            'Build your reputation with verified reviews.',
            style: getTextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),

          Text(
            'Deliver exceptional service and grow your ',
            style: getTextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'credibility with real client feedback',
            style: getTextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
