import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/overview/controller/overview_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBookingRequests extends StatelessWidget {
  AllBookingRequests({super.key});
  final OverviewController controller = Get.find<OverviewController>();
  final bool isDarkMode =
      Get.put(VenueOwnerProfileController()).isDarkMode.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff151515) : AppColors.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'All Booking Requests',
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDarkMode ? const Color(0xff151515) : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: controller.bookingreviews.length,
        itemBuilder: (context, index) {
          var reviews = controller.bookingreviews[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xff32383D) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      isDarkMode
                          ? const Color(0xff32383D)
                          : const Color(0xffEBEBEB),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff000000).withValues(alpha:  0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            reviews["image"]!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reviews["title"]!,
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color:
                                    isDarkMode
                                        ? const Color(0xffEBEBEB)
                                        : const Color(0xff333333),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              reviews["subtitle"] ?? '',
                              style: getTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff999999),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Image.asset(
                          IconPath.check,
                          width: 28,
                          height: 28,
                          color:
                              isDarkMode
                                  ? const Color(0xffD4AF37)
                                  : const Color(0xff003366),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 16,
                          color: const Color(0xff8A8A8A),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          reviews["date"]!,
                          style: getTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color:
                                isDarkMode
                                    ? const Color(0xff8A8A8A)
                                    : const Color(0xff767676),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          reviews["time"]!,
                          style: getTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color:
                                isDarkMode
                                    ? const Color(0xff8A8A8A)
                                    : const Color(0xff767676),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                reviews["status"] == "Accept"
                                    ? Color(0xff003366)
                                    : Color(0xff003366),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            reviews["status"]!,
                            style: getTextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color:
                                  reviews["status"] == "Accept"
                                      ? Color(0xffE6EBF0)
                                      : Color(0xffE6EBF0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
