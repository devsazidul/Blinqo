import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(padding: const EdgeInsets.all(20.0), child: Column(
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(ImagePath.profile,width: 40,height: 40,fit: BoxFit.cover,),
                  ),
                  SizedBox(width:8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Dianne Russell",style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:Color(0xff333333)

                      ),),
                      SizedBox(height: 10,),
                      Text('Venue Owner',style: getTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color:Color(0xffA1A1A1),
                      ),)

                    ],
                  ),
                  Spacer(),
                  Container(
                 height: 42,
                    width: 82,
                    decoration: BoxDecoration(
                      color:Color(0xffD4AF37),
                    borderRadius:BorderRadius.circular(6),
                    ),
                   child: Center(
                     child: Text("Go Pro",style: getTextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.w700,
                       color:Colors.white,
                     ),),
                   ),
                  ),
                  SizedBox(width: 10,),
                  Icon(Icons.notifications,size: 30,)
                ],
              ),
              SizedBox(height: 32,),
              Container(
                width: MediaQuery.of(context).size.width * 0.85, // 85% of screen width
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xff003366).withOpacity(0.3),
                    Color(0xff0066CC).withOpacity(0.3),

                  ],
                  begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,

                  ),
                  borderRadius:BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(

                      ),

                    )
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
