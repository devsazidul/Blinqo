import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/event_planner/onboring/home_event_planner.dart';
import 'package:blinqo/features/splasho_screen/screen/splasho_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboringScreen extends StatelessWidget {
  final PageController pageController = PageController();
  final PageControllerController controller = Get.put(
    PageControllerController(),
  );
  OnboringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFD9D9D9),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0x00000000), Color(0xFF031A30)],
            ),
          ),
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
                bottom: 120,
                left: MediaQuery.of(context).size.width * 0.35,
                child: Obx(() {
                  return Row(
                    children: List.generate(
                      3,
                      (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 10,
                        width: controller.currentPage.value == index ? 22 : 8,
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
                bottom: 48,
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
                      return null;
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Image.asset(ImagePath.serviceprovider01, width: 236, height: 485),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get noticed by local event organizers.',
                style: getTextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Showcase your services and reach clients looking for your expertise.',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
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
    return Column(
      children: [
        Image.asset(ImagePath.serviceprovider02, width: 236, height: 485),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Secure bookings with easy payments.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Receive direct booking requests and manage payments seamlessly.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
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
    return Column(
      children: [
        Image.asset(ImagePath.serviceprovider03, width: 236, height: 485),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Secure bookings with easy payments.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Receive direct booking requests and manage payments seamlessly.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
