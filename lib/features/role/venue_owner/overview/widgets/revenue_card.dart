import 'package:blinqo/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/overview/controller/overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RevenueCard extends StatelessWidget {
  RevenueCard({super.key});
  final int totalRevenue;
  final int currentMonthRevenue;
  final int growthRate;
  final int pendingBookings;

  RevenueCard({
    super.key,
    required this.totalRevenue,
    required this.currentMonthRevenue,
    required this.growthRate,
    required this.pendingBookings,
  });


  final OverviewController controller = Get.find<OverviewController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [Color(0xff0066CC), Color(0xff003366)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Total Revenue',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffB0C0D0),
                  ),
                ),
                Spacer(),
                Container(
                  width: 85,
                  height: 33,
                  decoration: BoxDecoration(
                    color: Color(0xff003366),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Row(
                      children: [
                        Image.asset(ImagePath.move, height: 20, width: 22),
                        Text(
                          '$growthRate%',
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Text(
              controller.totalRevenue.value.toString(),
              style: getTextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Text(
                  'This Month',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffB0C0D0),
                  ),
                ),
                Spacer(),
                Text(
                  'Pending Booking',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffB0C0D0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1),
            Row(
              children: [
                // this month
                Text(
                  '\$${currentMonthRevenue.toString()}',
                  style: getTextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    pendingBookings.toString(),
                    style: getTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Color(0xffD4A537),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
