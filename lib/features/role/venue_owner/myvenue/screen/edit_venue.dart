import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';

class EditVenue extends StatelessWidget {
  final String image;
  const EditVenue({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    TextEditingController venueName = TextEditingController();
    TextEditingController location = TextEditingController();
    TextEditingController numberGuests=TextEditingController();
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: 0.8,
                  child: Image.asset(
                    image,
                    width: double.infinity,
                  height: screenHeight*0.4,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xff161616),
                          Color(0xff000000).withOpacity(.1),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 24,
                          top: 40,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: const Color(0xFFD9D9D9),
                            child: Image.asset(IconPath.arrowLeftAlt),
                          ),
                        ),
                        Positioned(
                          left: 135,
                          top: 48,
                          child: Text(
                            "View Details",
                            style: getTextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 26,
                          right: 26,
                          child: Image.asset(
                            IconPath.edit,
                            width: 32,
                            height: 32,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(padding: EdgeInsets.all(20),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity  ,

                  child: TextField(
                    controller: venueName,
                    decoration: InputDecoration(
                        labelText: "Venue Name",
                        labelStyle: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff767676),
                        )
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                SizedBox(
                 width: double.infinity,
                  child: TextField(
                    controller: location,
                    decoration: InputDecoration(
                        labelText: "Location",
                        labelStyle: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff767676),
                        )
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Text('Select From Map',style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff333333)
                ),),
                SizedBox(height: 12),
                Container(

                  width: double.infinity,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: Color(0xffABB7C2),
                    )
                  ),
                  child: Image.asset(
                    ImagePath.location,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16,),
                SizedBox(
                  width: double.infinity ,

                  child: TextField(
                    controller: numberGuests,
                    decoration: InputDecoration(
                        labelText: "Number of Guests",
                        labelStyle: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff767676),
                        )
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Text('Amenities',
                    style: getTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: const Color(0xff333333),
                    )),
                SizedBox(height: 5,),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: screenHeight*0.03,
                        width: screenWidth*0.15,
                        decoration: BoxDecoration(

                          color: Color(0xffFBF7EB),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              width: 1,
                              color: Color(0xffC0C0C0),
                            )
                        ),child: Row(

                        children: [
                          SizedBox(width: 5,),
                          Icon(Icons.wifi,size: 14,color: Color(0xffD4AF37),),
                          SizedBox(width: 8),
                          Text('Wifi',style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333)
                          ),)
                        ],
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: screenHeight*0.03,
                        width: screenWidth*0.22,
                        decoration: BoxDecoration(
                            color: Color(0xffFBF7EB),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              width: 1,
                              color: Color(0xffC0C0C0),
                            )
                        ),child: Row(

                        children: [
                          SizedBox(width: 5,),
                          Icon(Icons.wifi,size: 14,color: Color(0xffD4AF37),),
                          SizedBox(width: 8),
                          Text('Parking',style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333)
                          ),)
                        ],
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: screenHeight*0.03,
                        width: screenWidth*0.15,
                        decoration: BoxDecoration(
                            color: Color(0xffFBF7EB),
                            borderRadius: BorderRadius.circular(32),

                            border: Border.all(
                              width: 1,
                              color: Color(0xffC0C0C0),
                            )
                        ),child: Row(

                        children: [
                          SizedBox(width: 5,),
                          Icon(Icons.wifi,size: 14,color: Color(0xffD4AF37),),
                          SizedBox(width: 8),
                          Text('AC',style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333)
                          ),)
                        ],
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: screenHeight*0.03,
                        width: screenWidth*0.15,
                        decoration: BoxDecoration(
                            color: Color(0xffFBF7EB),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              width: 1,
                              color: Color(0xffC0C0C0),
                            )
                        ),child: Row(

                        children: [
                          SizedBox(width: 5,),
                          Icon(Icons.wifi,size: 14,color: Color(0xffD4AF37),),
                          SizedBox(width: 8),
                          Text('Pool',style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333)
                          ),)
                        ],
                      ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 16,),
                Text('Select From Here',
                    style: getTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: const Color(0xff333333),
                    )),
                SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      height:screenHeight*0.028,
                      width: screenWidth*0.28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(34),
                        color: Color(0xffFFFFFFF),

                        boxShadow: [
                          BoxShadow(
                            color:Color(0xff000000).withOpacity(.6),//sersr
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          )
                        ]
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.wifi,size:16 ,color:Color(0xff333333) ,),
                          SizedBox(width: 8,),

                        ],
                      ),
                    )
                  ],
                )


              ],
            ))
          ],
        ),
      ),
    );
  }
}
