import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/app_sizes.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/team/controller/shifcontroller.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/addshift.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/schedule.dart';
import 'package:blinqo/features/role/venue_owner/team/widget/custom_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
class Createshift extends StatelessWidget {
  final String? title;
  const Createshift({super.key, this.title});
  @override
  Widget build(BuildContext context) {
    final ShiftController controller = Get.put(ShiftController());
    TextEditingController textEditingController = TextEditingController();
   
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
                    SizedBox(width:screenWidth*0.20),
                    Text(
                    title ?? 'Create Shift',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff333333),
                      ),
                    ),
                    Spacer(),
                  if(title!=null)
                  Image.asset(IconPath.delete,color: Color(0xff003366),height: 15,width: 15,)
                    
                  ],
                ),
                SizedBox(height: 19),
                Container(width: double.infinity, child: CustomDatePicker()),
                SizedBox(height: 32),
                Row(
                  children: [
                    // Start Time
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.pickTime(isStartTime: true),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Obx(
                            () => Text(
                              controller.startTime.value != null
                                  ? controller.startTime.value!.format(context)
                                  : "Start Time",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),

                    // End Time
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.pickTime(isStartTime: false),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Obx(
                            () => Text(
                              controller.endTime.value != null
                                  ? controller.endTime.value!.format(context)
                                  : "End Time",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),

                    // Duration
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade200,
                        ),
                        child: Obx(
                          () => Text(
                            controller.duration,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
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
                    color: Color(0xff333333),
                  ),
                ),
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    isCollapsed: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                SizedBox(height: 40),
                InkWell( 
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
                          color: Color(0xff333333),
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
                       child: Obx(() => Center(child: Text(controller.selectedEmployees.length.toString()))),

                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap:(){
                      Get.to(()=>Addshift());
                    },
                    child: Container(
                      height: 46,
                      width: 53,
                      decoration: BoxDecoration(
                        color: Color(0xff003366),
                       boxShadow: [
                        BoxShadow(
                          color: Color(0xff000000 ).withValues(alpha: .6),
                          offset: Offset(0, 1),
                          blurRadius: 2
                       
                        )
                       ],
                        borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(34),
                                  topRight: Radius.circular(34),
                                    bottomLeft: Radius.circular(34),
                                    bottomRight: Radius.circular(34),
                      ),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ), //
                    ),
                  ),
                ),
                SizedBox(height: 20),
Obx(() {
  return Column(
    children: controller.selectedEmployees.map((employee) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 8), // spacing between cards
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xffEBEBEB), width: 1),
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
                color: Color(0xff333333),
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
        Icon(Icons.edit_outlined,size:24 ,
        color: Color(0xff003366),)
          ],
        )
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
