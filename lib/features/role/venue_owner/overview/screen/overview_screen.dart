import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/overview/controller/overview_controller.dart';
import 'package:blinqo/features/role/venue_owner/overview/screen/addcard_screen.dart';
import 'package:blinqo/features/role/venue_owner/overview/widgets/custom_over_appbar.dart';
import 'package:blinqo/features/role/venue_owner/overview/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/revenue_card.dart';
class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> reviews = [
      {
        "title": "Corporate Event",
        "subtitle": "Conference Hall",
         "date":"15 March,2025",
          "time":"3.00 PM",
        "image": ImagePath.event,
          "status":"Confirmed"

      },
      {
        "title": "Team Building Retreat",
        "subtitle": "Lakeside Lodge",
        "date":"22 April,2025",
        "time":"10.00 AM",
        "image": ImagePath.event,
        "status":"Pending"




      },
      {
        "title": "Product Launch",
        "subtitle": "Main Auditorium",
        "date":"30 May,2025",
        "time":"1:00 PM",
        "image": ImagePath.event,
        "status":"Confirmed"
      }
    ];

    final OverviewController controller = Get.put(OverviewController());
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
                Obx(
                  () =>
                      controller.isPayment.value
                          ? RevenueCard(
                            revenue: '\$92,500',
                            percentage: '12.5%',
                            pendingBooking: '\&20,500',
                            bookingsCount: 5,
                          )
                          : PaymentCard(),
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
                SizedBox(
                  height: 300,
                  child: reviews.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 232,
                          width: 232,
                          child: Image.asset(ImagePath.overview_box),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'It looks like no events have been\n       scheduled yet.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff333333),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                      : ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          height: 107,
                          width: double.infinity,
                          decoration: BoxDecoration(
                           color:Color(0xffEBEBEB),
                            borderRadius: BorderRadius.circular(12),

                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(.2),
                                blurRadius: 7,
                                spreadRadius: 2,

                                offset: Offset(0, 3),
                              )
                            ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 45,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.asset(reviews[index]["image"]!,fit: BoxFit.cover,),

                                    ),
                                    SizedBox(width: 15,),
                                    Column(
                                      children: [
                                        Text(reviews[index]["title"]!,style: getTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff333333),
                                        ),),
                                        SizedBox(height: 4,),
                                        Text(reviews[index]["subtitle"]!,style: getTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff999999),
                                          textAlign: TextAlign.start,
                                        ),),


                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(ImagePath.pending,fit: BoxFit.cover,),
                                    ),



                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_month,size: 15,color: Color(0xff8A8A8A),),
                                    SizedBox(width: 5,),
                                    Text(reviews[index]["date"]!,style: getTextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),),
                                    SizedBox(
                                      width:16 ,
                                    ),
                                    Text(reviews[index]["time"]!,style: getTextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),),
                                   Spacer(),
                                    Container(
                                      height: 22,
                                      width: 68,

                                      decoration:BoxDecoration(
                                        color: Color(0xff37D459).withOpacity(.20),
                                        borderRadius: BorderRadius.circular(4),

                                      ),
                                      child: Center(
                                        child: Text(reviews[index]["status"]!,style: getTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff37D441),
                                        ),),
                                      ),
                                    )


                                  ],
                                )

                              ],
                            )
                          ),
                        
                        ),
                      );
                    },
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
                    child: Image.asset(ImagePath.review_pic),
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