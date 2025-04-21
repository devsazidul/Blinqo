import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/controller/sp_home_Controller.dart';
import 'package:blinqo/features/role/venue_owner/team/controller/teamcontroller.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/createshift.dart';
import 'package:blinqo/features/role/venue_owner/team/widget/custom_calendar.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});
  @override
  Widget build(BuildContext context) {
    final TeamControllerGetx teamControllerGetx =
        Get.find<TeamControllerGetx>();
    final SpHomeController spHomeController = Get.put(SpHomeController());

    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 26),
              Container(
                width: double.infinity,
                child: const CustomDatePicker(),
              ),
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                child: Obx(() {
                  if (teamControllerGetx.containerList.isEmpty) {
                    // List is empty → Show image
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: Image.asset(
                          ImagePath.empty,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    );
                  } else {
                    // List is not empty → Show container list
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: teamControllerGetx.containerList.length,
                      itemBuilder: (context, index) {
                        final item = teamControllerGetx.containerList[index];
                        return InkWell(
                          onTap: () {
                            // You can add tap logic here
                          },
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 12),
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xffFFFFFF),
                              border: Border.all(
                                width: 1,
                                color: Color(0xffEBEBEB),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 12),
                                Text(
                                  item['title'] ?? '',
                                  style: getTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      item['date'] ?? '',
                                      style: getTextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff5C5C5C),
                                      ),
                                    ),
                                    Spacer(),
                                    Image.asset(
                                      IconPath.editPencil,
                                      height: 18,
                                      width: 18,
                                      color: Color(0xff003366),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text('Employee '),
                                    SizedBox(width: 24),
                                    Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Color(
                                          0xffD4AF37,
                                        ).withValues(alpha: .10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          item['employee'] ?? '',
                                          style: getTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffD4AF37),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
              SizedBox(height: 40,),
              InkWell(
                onTap: (){
                 Get.to(()=>Createshift());
                },
                child: Container(
                  width: double.infinity,
                  height: screenHeight*0.070,
                  decoration: BoxDecoration(
                    color: Color(0xff003366),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Add Shift',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xffF4F4F4)),),
                      SizedBox(width: 15,),
                      Icon(Icons.add,color: Color(0xffF4F4F4),weight: 24,),
                    ],
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
