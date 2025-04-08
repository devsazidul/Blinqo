import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/overview/screen/addcard_screen.dart';
import 'package:blinqo/features/role/venue_owner/overview/widgets/custom_over_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileRow(
                  imagePath: ImagePath.profile,
                  name: 'Dianne Russell',
                  role: 'Venue Owner',
                ),
                SizedBox(height: 32),
                Container(
                  width:
                      MediaQuery.of(context).size.width *
                      0.85, // 85% of screen width
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff003366).withOpacity(0.3),
                        Color(0xff0066CC).withOpacity(0.3),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: ClipOval(
                            child: Container(
                              height: 24,
                              width: 24,
                              color: Colors.indigo,
                              child: InkWell(
                                onTap: () {
                                  Get.off(() => AddcardScreen());
                                },
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Please Add Payment Details',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Upcoming Bookings',
                  style: getTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(height: 32),
                Center(
                  child: Container(
                    height: 232, // 214/1000 = 0.214
                    width: 232, // 184/1000 = 0.184
                    child: Image.asset(ImagePath.overviewbox),
                  ),
                ),
                Center(
                  child: Text(
                    'It looks like no events have been\n       scheduled yet.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff333333),
                    ),
                  ),
                ),
                SizedBox(height: 67),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff003366),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Add Venue  +',
                        style: getTextStyle(
                          fontWeight: FontWeight.w500,

                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Recent Views',
                  style: getTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    height: 140,
                    width: 188,
                    child: Image.asset(ImagePath.reviewpic),
                  ),
                ),
                SizedBox(height: 20),

                Center(
                  child: SizedBox(
                    width: 220,

                    child: Text(
                      "No reviews have been submitted yet.",
                      textAlign: TextAlign.center,

                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff333333),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
