import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/constants/icon_path.dart';

class VenueDetailsScreen extends StatelessWidget {
  final String title;
  final String address;
  final String guest;
  final String rating;
  final String image;

  const VenueDetailsScreen({
    super.key,
    required this.title,
    required this.address,
    required this.guest,
    required this.rating,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.backgroundColor,
    body:SingleChildScrollView(
      child: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [

              Opacity(
                opacity: 0.8,
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * (326 / MediaQuery.of(context).size.height),
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
                        Color(0xff000000).withOpacity(.1),// মাঝখানে একটু হালকা

                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                     Positioned(left: 24,
                       top: 24,

                       child: CircleAvatar(
                       radius: 20,
                       backgroundColor: const Color(0xFFD9D9D9),
                       child: Image.asset(IconPath.arrowLeftAlt),
                     ),),
                      Positioned(left: 135,top:30,child:Text("View Details",style:getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffFFFFFF),
                      ),) ),
                      Positioned(bottom: 26,right:26,child: Image.asset(IconPath.rotatevenue,width: 26,height: 17,))
                    ],

                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
         Padding(padding: EdgeInsets.symmetric(horizontal: 20),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
          Row(
            children: [
              Text(title,style: getTextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xff333333),
              ),),
              SizedBox(width: 10,),
              Image.asset(IconPath.verify,height: 16,width: 16,),
              Spacer(),
              Container(
                height:MediaQuery.sizeOf(context).height*(27 / MediaQuery.of(context).size.height),
                width: MediaQuery.sizeOf(context).width*(76/MediaQuery.of(context).size.width),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color(0xffD4AF37),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Text('Edit',style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:Color(0xffFFFFFF),
                    ),),

                    SizedBox(width: 8,),
                    Icon(Icons.edit,color: Colors.white,size: 15,)
                  ],
                ),
              )
            ],
          )

           ],
         ),)

        ],

      ),),
    )
    );
  }
}
