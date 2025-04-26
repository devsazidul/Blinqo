// ignore_for_file: file_names

import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/overview/controller/overview_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/image_path.dart';

class BookingRequest extends StatelessWidget {
   BookingRequest({
    super.key,
  });

   final OverviewController controller = Get.find<OverviewController>();

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.put(VenueOwnerProfileController()).isDarkMode.value;///
    return SizedBox(
      height: 400,
      child:
      controller.reviews.isEmpty
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 250,
              width: 232,
              child: Image.asset(ImagePath.overviewbox),
            ),
            SizedBox(height: 10),
            Text(
              'It looks like no events have been\n       scheduled yet.',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color:isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
          : ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var reviews = controller.bookingreviews[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(
             
              decoration: BoxDecoration(
                color:isDarkMode ? Color(0xff32383D) : Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color:isDarkMode ? Color(0xff32383D) : Color(0xffEBEBEB),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff000000).withValues(alpha:  .1),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.width * 0.025,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            reviews["image"]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.03), // Reduced spacing
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reviews["title"]!,
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color:isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                              ),
                            ),
                            SizedBox(height: 4), // Reduced from 5 to 4
                            Text(
                              reviews["subtitle"]!,
                              style: getTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff999999),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.045, // Slightly reduced
                          child: Image.asset(
                            IconPath.check,
                            width:37 ,
                            height: 28,
                            fit: BoxFit.cover,
                            color: isDarkMode ? Color(0xff8D4AF37) : Color(0xff003366),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6), // Reduced from 10
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: MediaQuery.of(context).size.width * 0.035, // Reduced size
                          color: Color(0xff8A8A8A),
                        ),
                        SizedBox(width: 6), // Reduced width spacing
                        Text(
                          reviews["date"]!,
                          style: getTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: isDarkMode ? Color(0xff8A8A8A) : Color(0xff767676),
                          ),
                        ),
                        SizedBox(width: 12), // Reduced from 16
                        Text(
                          reviews["time"]!,
                          style: getTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: isDarkMode ? Color(0xff8A8A8A) : Color(0xff767676),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 22, // Reduced from 25
                          width: MediaQuery.of(context).size.width * 0.17, // Slightly reduced
                          decoration: BoxDecoration(
                            color: reviews["status"] == "Accept"
                                ? Color(0xff003366)
                                : Color(0xff003366),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              reviews["status"]!,
                              style: getTextStyle(
                                fontSize: 11, // Reduced from 12
                                fontWeight: FontWeight.w400,
                                color: reviews["status"] == "Accept"
                                    ? Color(0xffE6EBF0)
                                    : Color(0xffE6EBF0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )

            ),
          );

        },
      ),
    );
  }
}