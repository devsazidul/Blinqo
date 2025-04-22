import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/overview/controller/overview_controller.dart';
import 'package:blinqo/features/role/venue_owner/overview/widgets/custom_over_appbar.dart';
import 'package:blinqo/features/role/venue_owner/overview/widgets/payment_card.dart';
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
    final bool isDarkMode = Get.put(VenueOwnerProfileController()).isDarkMode.value;
    
    List <Map<String,String>>  seereview =[
      {
       "title":"Floyd Miles",
        "time":"Today",
        "image":ImagePath.reviewer1,
          "desc":"Lorem ipsum dolor sit amet consectetur. Interdum ac hac nec etiam. Augue etiam ornare eu velit ultrices pharetra. Velit fringilla tellus justo sed et praesent quam praesent in. Scelerisque venenatis leo nunc convallis vel amet faucibus mattis parturient."
      },
      {
        "title":"Renee Ellis",
        "time":"2 days ago",
        "image": ImagePath.reviewer3,
        "desc":"Aenean consectetur diam vel urna interdum, in pharetra sapien posuere. Curabitur varius eros sit amet nisi faucibus, eu posuere eros maximus. Vivamus nec lacus ut nisl dignissim convallis.",
        },
    ];
    final OverviewController controller = Get.put(OverviewController());
    return Scaffold(
      backgroundColor:isDarkMode?Color(0xff151515): AppColors.backgroundColor,
      appBar: ProfileRow(
        imagePath: ImagePath.profile,
        name: 'Dianne Russell',
        role: 'Venue Owner',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Obx(
                () =>
                    controller.isPayment.value
                        ? RevenueCard()
                        : PaymentCard(),
              ),
              SizedBox(height: 40),
              Text(
                'Upcoming Bookings',
                style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color:isDarkMode?Color(0xffEBEBEB): Color(0xff333333),
                ),
              ),
              if(controller.reviews.isNotEmpty)
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               children: [
                 Spacer(),
                 InkWell(
                   onTap:(){},
                   child: Text('Explore All',style: getTextStyle(
                     fontWeight: FontWeight.w500,
                     fontSize: 14,
                     color:isDarkMode?Color(0xffEBEBEB): Color(0xff444444),
                   ),),
                 ),
                 Icon(Icons.arrow_right_alt)
               ],
             ),
           ),
              SizedBox(height: 7),
              NewWidget(),
              SizedBox(height: 30),
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
                  color:isDarkMode?Color(0xffEBEBEB): Color(0xff333333),
                ),
              ),
              if(seereview.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Spacer(),
                      InkWell(
                        onTap:(){},
                        child: Text('Explore All',style: getTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color:isDarkMode?Color(0xffEBEBEB): Color(0xff444444),
                        ),),
                      ),
                      Icon(Icons.arrow_right_alt)
                    ],
                  ),
                ),
              SizedBox(height: 2),

              SizedBox(
                height: MediaQuery.of(context).size.height * (380 / MediaQuery.of(context).size.height),
                width: double.infinity,
                child: seereview.isEmpty?Center(
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
                            color:isDarkMode?Color(0xffEBEBEB): Color(0xff333333),
                          ),
                        ),
                      ),
                    ],
                  ),
                ):
                ListView.builder(itemCount: seereview.length,itemBuilder: (context,index){
                  return Padding(padding: EdgeInsets.all(20),
                    child: SizedBox(


                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child:Image.asset(
                                  seereview[index]["image"]!,
                                  fit: BoxFit.cover,
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              SizedBox(width:8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(seereview[index]["title"]!,style: getTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color:isDarkMode?Color(0xffEBEBEB): Color(0xff333333),
                                  ),),
                                   Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.star,color: Color(0xffF0C020),size: 15,),
                                    Icon(Icons.star,color: Color(0xffF0C020),size: 15,),
                                    Icon(Icons.star,color: Color(0xffF0C020),size: 15,),
                                    Icon(Icons.star,color: Color(0xffF0C020),size: 15,),
                                    Icon(Icons.star,color: Color(0xffF0C020),size: 15,),
                                  ],
                                )

                                ],
                              ),
                              Spacer(),
                              Text(seereview[index]["time"]!,style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffC0C0C0),
                              ),)
                            ],
                          ),
                          SizedBox(height: 15,),

                          Text(seereview[index]["desc"]!,style:getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color:isDarkMode?Color(0xffA1A1A1): Color(0xff5C5C5C)
                          ),)

                        ],


                      ),
                    ),
                  );
                }),
              )

            ],
          ),
        ),
      ),
    );
  }
}


