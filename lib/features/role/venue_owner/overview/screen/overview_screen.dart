import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/screen/venue_home_page.dart';
import 'package:blinqo/features/role/venue_owner/overview/controller/overview_controller.dart';
import 'package:blinqo/features/role/venue_owner/overview/screen/all_coming_booking.dart';
import 'package:blinqo/features/role/venue_owner/overview/screen/bookviewerreview.dart';
import 'package:blinqo/features/role/venue_owner/overview/widgets/custom_over_appbar.dart';
import 'package:blinqo/features/role/venue_owner/overview/widgets/payment_card.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../widgets/NewWidget.dart';
import '../widgets/revenue_card.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final OverviewController controller = Get.put(OverviewController());
    final user = EventAuthController.profileInfo;
    return Scaffold(
      backgroundColor:
          isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
      appBar: ProfileRow(
        imagePath: user?.profile?.image?.path ?? "",
        name: user?.profile?.name ?? "Unknown",
        role: user?.role.first.toLowerCase() ?? "Unknown",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Obx(
                () =>
                    controller.isPayment.value
                        ? RevenueCard(
                          totalRevenue: 1000,
                          currentMonthRevenue: 1500,
                          growthRate: 10,
                          pendingBookings: 5,
                        )
                        : PaymentCard(),
              ),
              SizedBox(height: 25),
              Text(
                'Upcoming Bookings',
                style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                ),
              ),
              if (controller.reviews.isNotEmpty)
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(() => AllUpcomingBookingsScreen());
                      },
                      child: Text(
                        'Explore All',
                        style: getTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color:
                              isDarkMode
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff444444),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_right_alt,
                      color: isDarkMode ? Color(0xffEBEBEB) : null,
                      size: 18,
                    ),
                  ],
                ),

              NewWidget(),

              InkWell(
                onTap: () {
                  Get.to(() => VenueHomePage());
                },
                child: Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff003366),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add Venue  ',
                        style: getTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 15),
                      Icon(Icons.add, size: 20, color: Color(0xffF4F4F4)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Recent Reviews',
                style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                ),
              ),
              if (controller.seereview.isNotEmpty)
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(() => Bookviewerreview());
                      },
                      child: Text(
                        'Explore All',
                        style: getTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color:
                              isDarkMode
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff444444),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_right_alt,
                      color: isDarkMode ? Color(0xffEBEBEB) : null,
                      size: 18,
                    ),
                  ],
                ),
              SizedBox(
                width: double.infinity,
                child:
                    controller.seereview.isEmpty
                        ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 140,
                                width: 188,
                                child: Image.asset(ImagePath.reviewpic),
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                width: 220,
                                child: Text(
                                  "No reviews have been submitted yet.",
                                  textAlign: TextAlign.center,
                                  style: getTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        isDarkMode
                                            ? Color(0xffEBEBEB)
                                            : Color(0xff333333),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ClipOval(
                                          child: Image.asset(
                                            controller
                                                .seereview[index]["image"]!,
                                            fit: BoxFit.cover,
                                            height: 40,
                                            width: 40,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller
                                                  .seereview[index]["title"]!,
                                              style: getTextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    isDarkMode
                                                        ? Color(0xffEBEBEB)
                                                        : Color(0xff333333),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffF0C020),
                                                  size: 15,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffF0C020),
                                                  size: 15,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffF0C020),
                                                  size: 15,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffF0C020),
                                                  size: 15,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffF0C020),
                                                  size: 15,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Text(
                                          controller.seereview[index]["time"]!,
                                          style: getTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffC0C0C0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      controller.seereview[index]["desc"]!,
                                      maxLines: null,
                                      style: getTextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            isDarkMode
                                                ? Color(0xffA1A1A1)
                                                : Color(0xff5C5C5C),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
