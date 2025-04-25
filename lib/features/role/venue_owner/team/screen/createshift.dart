import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/team/controller/shifcontroller.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/addshift.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/teaminformation.dart';
import 'package:blinqo/features/role/venue_owner/team/widget/custom_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Createshift extends StatelessWidget {
  final String? title;

  const Createshift({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final ShiftController controller = Get.put(ShiftController());
    TextEditingController textEditingController = TextEditingController();

    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    return Scaffold(
      backgroundColor:
          isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xff333333).withValues(alpha: .1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            IconPath.arrowLeftAlt,
                            width: 20,
                            height: 20,
                            color: Color(0xff1C1B1F),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.20),
                    Text(
                      title ?? 'Create Shift',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color:
                            isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                      ),
                    ),
                    Spacer(),
                    if (title != null)
                      Image.asset(
                        IconPath.delete,
                        color:
                            isDarkMode ? Color(0xffD4AF37) : Color(0xff003366),
                        height: 15,
                        width: 15,
                      ),
                  ],
                ),
                SizedBox(height: 19),
                SizedBox(width: double.infinity, child: CustomDatePicker()),
                SizedBox(height: 32),
     
              Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // Start Time
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Start Time',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff333333),
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              controller.pickTime(isStartTime: true);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffC0C0C0),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                        controller.startTime.value == null
                            ? 'Select time'
                            : controller.startTime.value!.format(Get.context!),
                        style: TextStyle(
                          fontSize: 14,
                          color: controller.startTime.value == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                      )),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xff003366),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),

    SizedBox(width: 4), // Reduced gap between Start & End

    // End Time
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'End Time',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff333333),
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              controller.pickTime(isStartTime: false); // End time এর জন্য false পাঠানো হচ্ছে
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffC0C0C0),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                        controller.endTime.value == null
                            ? 'Select time'
                            : controller.endTime.value!.format(Get.context!),
                        style: TextStyle(
                          fontSize: 14,
                          color: controller.endTime.value == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                      )),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Color(0xff003366),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),

    SizedBox(width: 10),

    // Duration
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Duration',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff333333),
            ),
          ),
          SizedBox(height: 8), // Added gap below the Duration text
          Obx(() => Text(
            controller.duration,
            style: TextStyle(fontSize: 14),
          )),
        ],
      ),
    ),
  ],
),

                SizedBox(height: 40),
                Text(
                  'Shift Name',
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                  ),
                ),
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color:isDarkMode ? Color(0xff003366) : Color(0xffC0C0C0)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:isDarkMode ? Color(0xff003366) : Color(0xffC0C0C0)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:isDarkMode ? Color(0xff003366) : Color(0xffC0C0C0  )),
                    ),
                    isCollapsed: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: TextStyle(
                    color: isDarkMode ? Color(0xffEBEBEB) : Colors.black,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: double.infinity,
                    height: screenHeight * 0.070,
                    decoration: BoxDecoration(
                      color: Color(0xff003366),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Create Shift',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffF4F4F4),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Employees',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              isDarkMode
                                  ? Color(0xffD4AF37)
                                  : Color(0xff333333),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xffD4AF37).withValues(alpha: .10),
                        ),
                        child: Obx(
                          () => Center(
                            child: Text(
                              controller.selectedEmployees.length.toString(),
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color:
                                    isDarkMode
                                        ? Color(0xffD4AF37)
                                        : Color(0xffD4AF37),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => Addshift());
                    },
                    child: Container(
                      height: 46,
                      width: 53,
                      decoration: BoxDecoration(
                        color: Color(0xff003366),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withValues(alpha: .6),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(34),
                          topRight: Radius.circular(34),
                          bottomLeft: Radius.circular(34),
                          bottomRight: Radius.circular(34),
                        ),
                      ),
                      child: Icon(Icons.add, color: Colors.white), //
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Obx(() {
                  return Column(
                    children:
                        controller.selectedEmployees.map((employee) {
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 8),
                            // spacing between cards
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color:isDarkMode ? Color(0xff32383D) : Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color:isDarkMode ? Color(0xff32383D) : Color(0xffEBEBEB),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      employee.name,
                                      style: getTextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      employee.position,
                                      style: getTextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffA1A1A1),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                InkWell(
                                  onTap:(){
                                    Get.to(()=>EmployeeInformation());
                                  },
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 24,
                                    color:isDarkMode ? Color(0xffD4AF37) : Color(0xff003366),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
