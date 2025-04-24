import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/event_planner/venue_details/widget/venue_image_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class VenueDetails extends StatelessWidget {
  const VenueDetails({super.key});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
     final double screenWidth = screenSize.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VenueImageHeader(onBackTap: () => Get.back()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'The Grand Hall',
                        style: getTextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff333333),
                        ),
                      ),
                      SizedBox(width: 8),
                      Image.asset(IconPath.verify, height: 16, width: 16),
                      SizedBox(width: screenWidth*0.068),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xff003366).withValues(alpha: .10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [               
                                Text(
                                  '\$',
                                  style: getTextStyle(
                                    color: Color(0xff003366),
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Set Price',
                                  style: getTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff003366),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12,),
                  Row(
                    children: [
                      Icon(Icons.star,size: 15,color: Color(0xffF0C020),),
                      SizedBox(width: 8),
                      Text('5.0',style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                      ),),
                     SizedBox(width: 8,),
                     Text('(345 reviews)',style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffABB7C2),
                     ),)
                      
                    ],
                  )
                ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}
