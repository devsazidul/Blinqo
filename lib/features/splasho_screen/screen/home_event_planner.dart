import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/image_path.dart';
import '../../profile_setup/profile_setup.dart';

class HomeEventPlanner extends StatelessWidget {
  const HomeEventPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImagePath.homeEventPlanner,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          Positioned(
            bottom: 120.w,
            left: 20.w,
            right: 20.w,
            child: Text(
              "Easily plan and manage\n your perfect even!t",
              style: getTextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Positioned(
            bottom: 40.w,
            left: 20.w,
            right: 20.w,
            child: GestureDetector(
              onTap: () {
                Get.to(ProfileSetup());
              },
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    "Get Started",
                    style: getTextStyle(
                      fontSize: 16.sp,
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
    );
  }
}
