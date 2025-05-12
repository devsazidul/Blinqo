import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/event_planner/bottom_nav_bar/screen/event_bottom_nav_bar.dart';
import 'package:blinqo/features/role/event_planner/profile_setup/controller/profile_setup_controller.dart';
import 'package:blinqo/features/role/event_planner/profile_setup/widgets/event_googlemap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileSetup extends StatelessWidget {
  ProfileSetup({super.key});
  final ProfileSetupController controller = Get.put(ProfileSetupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile Setup',
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode), 
            onPressed: () {}
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 80.h,
                width: 80.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffD9D9D9),
                ),
              ),
              Positioned(
                top: 50.w,
                left: 175.w,
                child: GestureDetector(
                  onTap: () => debugPrint('Edit button tapped!'),
                  child: Image.asset(
                    "assets/icons/edit.png",
                    height: 30.w,
                    width: 30.w,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          TextFormField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8),
              labelText: "Name",
              hintText: "type your name",
            ),
          ),
          SizedBox(height: 8.h),
          Obx(() {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0, color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: PopupMenuButton<String>(
                onSelected: (String value) {
                  controller.updateGender(value);
                },
                itemBuilder: (BuildContext context) {
                  return ['Male', 'Female'].map((String gender) {
                    return PopupMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList();
                },
                child: ListTile(
                  title: Text(controller.selectedGender.value),
                  trailing: const Icon(Icons.arrow_drop_down),
                ),
              ),
            );
          }),
          SizedBox(height: 10.h),
          TextFormField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8),
              labelText: "Location",
              hintText: "Enter your Location",
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Select From Map',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xff333333),
            ),
          ),
          SizedBox(height: 10.h),
          EventGoogleMap(),
          // SizedBox(height: 20.h),
          //         Align(
          //           alignment: Alignment.centerLeft,
          //           child: Text(
          //             "Event Preference",
          //             style: getTextStyle(
          //               fontSize: 20,
          //               fontWeight: FontWeight.w500,
          //               color:
          //                   themeMode == ThemeMode.dark
          //                       ? AppColors.primary
          //                       : AppColors.textColor,
          //             ),
          //           ),
          //         ),
          //         SizedBox(height: 20),

          //         //* ------------------ Event Preference Grid ------------------
          //         GetBuilder<SpProfileSetupController>(
          //           builder: (controller) {
          //             return GridView.count(
          //               shrinkWrap: true,
          //               physics: const NeverScrollableScrollPhysics(),
          //               crossAxisCount: 3,
          //               crossAxisSpacing: 12,
          //               mainAxisSpacing: 12,
          //               childAspectRatio: 0.7,
          //               children: List.generate(
          //                 controller.eventPreferenceList.length,
          //                 (index) {
          //                   final eventPreference =
          //                       controller.eventPreferenceList[index];
          //                   return GestureDetector(
          //                     onTap: () {
          //                       controller.toggleEventSelection(
          //                         eventPreference.id ?? '',
          //                       );
          //                     },
          //                     child: SpEventPreferenceCircleAvatar(
          //                       eventPreference: eventPreference,
          //                     ),
          //                   );
          //                 },
          //               ),
          //             );
          //           },
          //         ),
          ElevatedButton(
            onPressed: () {
              // Handle save action
              debugPrint('Save button tapped!');
              Get.offAll(() => EventBottomNavBar());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, 
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 100.w),
            ),
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}