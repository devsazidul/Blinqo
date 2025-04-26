import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/ep_service_provider_controller/ep_service_provider_booking_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/ep_paymant_screen/ep_payment_option.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/service_provider/ep_service_provider_booking_screen3.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/service_provider/ep_service_provider_step_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpServicePoroviderBookingScreen2 extends StatelessWidget {
  final EpServiceProviderBookingController controller = Get.put(
    EpServiceProviderBookingController(),
  );

  EpServicePoroviderBookingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.appBarIcolor,
              child: Image.asset(
                IconPath.arrowleft,
                width: 20,
                height: 20,
                color: AppColors.textColor,
              ),
            ),
          ),
        ),
        title: Text(
          'Booking',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  IconPath.projectrequestimage,
                  width: 125,
                  height: 125,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Ronald Richards',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF003285),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  IconPath.projectrequestlocation,
                  width: 16,
                  height: 16,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10),
                Text('Radio Colony, Savar'),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('4.5'),
                SizedBox(width: 4),
                Image.asset(IconPath.ratinglogo, width: 11, height: 12),
                SizedBox(width: 30),
                Text('Project - 10'),
              ],
            ),

            SizedBox(height: 15),

            SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {
                Get.to(() => EpServiceProviderBookingScreen3());
              },
              icon: Icon(Icons.attach_money),
              label: Text('Set Price'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF003366),
                backgroundColor: Color(0xFFE6EBF0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Booking Timeline',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF003285),
              ),
            ),
            SizedBox(height: 12),

            // STEP INDICATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [EpServiceProviderStepIndicator()],
            ),
            const Divider(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Center(
                child: Text(
                  "Jhon's Birthday",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF003285),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  EventInfoTile(title: 'Organizer', value: 'John Doe Events'),
                  EventInfoTile(title: 'Venue', value: 'The Garden Hall'),
                  EventInfoTile(title: 'Location', value: 'New York'),
                  EventInfoTile(title: 'Date', value: '15/03/2025'),
                  EventInfoTile(title: 'Time', value: '10:00am–4:00pm'),
                  EventInfoTile(title: 'Guest', value: '100'),
                  EventInfoTile(title: 'Event Type', value: 'Birthday'),
                  //EventInfoTile(title: 'Price', value: '\$1200'),
                ],
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(EpPaymentOption());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE6EBF0),
                foregroundColor: Colors.blue,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              child: const Text(
                'proceed to payment',
                style: TextStyle(color: Color(0xFF8AA1B9)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class EventInfoTile extends StatelessWidget {
  final String title;
  final String value;

  const EventInfoTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF767676),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
