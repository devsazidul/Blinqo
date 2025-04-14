import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/myview_controller.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/widget/custom_shape.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../overview/controller/overview_controller.dart';
import '../widget/custom_textfield.dart';
import '../widget/facilty_Tag.dart';
class EditVenue extends StatelessWidget {

  final String image;
  EditVenue({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(myvenuecontroller());
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
                CustomInputField(
                  controller: venueName,
                  label: "Venue Name",
                ),
                SizedBox(height: 16,),
                CustomInputField(
                  controller: location,
                  label: "Location",
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
                CustomInputField(
                  controller: numberGuests,
                  label: "Number of Guests",
                ),
                SizedBox(height: 15,),
                Text('Amenities',
                    style: getTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: const Color(0xff333333),
                    )),
                SizedBox(height: 5,),
                Row(
                  children: [
                    FacilityTag(
                      width: screenWidth * 0.18,
                      icon: Icons.wifi,
                      label: 'Wifi',
                    ),

                    SizedBox(width: 13,),
                    FacilityTag(
                      width: screenWidth * 0.24,
                      icon: Icons.wifi,
                      label: 'Parking',
                    ),

                    SizedBox(width: 13,),
                    FacilityTag(
                      width: screenWidth * 0.16,
                      icon: Icons.wifi,
                      label: 'AC',
                    ),

                    SizedBox(width: 13,),
                    FacilityTag(
                      width: screenWidth * 0.19,
                      icon: Icons.wifi,
                      label: 'Pool',
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  CustomShapeTag(label: 'Storage & lighting',  height: screenHeight * 0.05,
                    width: screenWidth * 0.38,
                    icon:Icon(Icons.wifi, size: 15, color: Color(0xffD4AF37)),

                  ),
                    SizedBox(width: .2,),
                    CustomShapeTag( icon:Icon(Icons.wifi, size: 15, color: Color(0xffD4AF37)),label: 'Sound System', height: screenHeight * 0.05, width:screenWidth * 0.38),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomShapeTag(label: 'Barservices',  height: screenHeight * 0.05, width:screenWidth*0.27,icon:Icon(Icons.wifi, size: 15, color: Color(0xffD4AF37)),),
                    SizedBox(width: .2,),
                    CustomShapeTag(label: 'Elecator', height: screenHeight * 0.05, width: screenHeight * 0.14,icon:Icon(Icons.wifi, size: 15, color: Color(0xffD4AF37)),),
                    CustomShapeTag(label: 'Restroom', height: screenHeight * 0.05, width: screenHeight * 0.15,icon:Icon(Icons.wifi, size: 15, color: Color(0xffD4AF37)),),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomShapeTag(label: 'Event Staff',  height: screenHeight * 0.05,
                      width: screenWidth * 0.30,
                      icon:Icon(Icons.wifi, size: 15, color: Color(0xffD4AF37)),

                    ),
                    SizedBox(width: .2,),
                    CustomShapeTag( icon:Icon(Icons.wifi, size: 15, color: Color(0xffD4AF37)),label: 'Sound System', height: screenHeight * 0.05, width:screenWidth * 0.38),
                  ],
                ),
                SizedBox(height: 19,),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 48,
                    height: 40,
                 decoration: BoxDecoration(
                   color:Color(0xff003366),
                   shape: BoxShape.circle
                 ),
                    child: Center(
                      child: Icon(Icons.add,color:Colors.white,size: 24,),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text('Decoration',style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff333333),
                ),),
                SizedBox(height: 16),
                SizedBox(
                  height: screenHeight * 0.249,
                  width: double.infinity,
                  child: Image.asset(ImagePath.venueview, fit: BoxFit.cover),
                ),
                SizedBox(height: 16,),
                Text(
                  'Table Shape',
                  style: getTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(height: 16),
                Obx(() {
                  final shapes = controller.tableShapeOptions;

                  return Wrap(
                    spacing: 5, // checkbox গুলোর মাঝে horizontal gap
                    runSpacing: 4, // new line হলে vertical gap
                    children: shapes.map((shape) {
                      final isSelected = controller.selectedShapes.contains(shape);
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: (_) => controller.toggleShape(shape),
                            activeColor: Color(0xff003366),
                          ),
                          Text(
                            shape,
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  );
                })















              ],
            ))
          ],
        ),
      ),
    );
  }
}
