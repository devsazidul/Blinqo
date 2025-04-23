import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/team/controller/teamcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart'; 
class EmployeeInformation extends StatelessWidget {
  const EmployeeInformation({super.key});
  @override
  Widget build(BuildContext context) {
      final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    TextEditingController firstname = TextEditingController();
    TextEditingController lastname = TextEditingController();
    TextEditingController role = TextEditingController();
    final TeamControllerGetx controller =Get.put(TeamControllerGetx());
    return Scaffold(
        backgroundColor:isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Text('Employee Information',style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color:  isDarkMode?Color(0xffEBEBEB): Color(0xff000000),
                ),),
                SizedBox(height:16 ,),
                SizedBox(
                  width: double.infinity,
                  
                 child: TextField(
                  controller: firstname,
                  style: getTextStyle(
                    color: isDarkMode?Color(0xffEBEBEB):Color(0xff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400 
                  ),
                  decoration: InputDecoration(
                    
                     enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffABB7C2),
                        width: 1,
                      )
                    ),
                    labelText: 'First Name',
                    labelStyle: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode?  Color(0xffC0C0C0): Color(0xff767676),
                    ),
                  ),
                 ),
                ),
                SizedBox(height: 12,),
                SizedBox(
                  width: double.infinity,
                 child: TextField(
                  controller: lastname,
                   style: getTextStyle(
                    color: isDarkMode?Color(0xffEBEBEB):Color(0xff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400 
                  ),
                  decoration: InputDecoration(
                     enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffABB7C2),
                        width: 1,
                      )
                    ),
                    labelText: 'Last Name',
                    labelStyle: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode?  Color(0xffC0C0C0): Color(0xff767676),
                    )
                  ),
                 ),
                ),
                SizedBox(height: 12,),
                 SizedBox(
                  width: double.infinity,
                 child: TextField(
                   style: getTextStyle(
                    color: isDarkMode?Color(0xffEBEBEB):Color(0xff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400 
                  ),
                  decoration: InputDecoration(
                     enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffABB7C2),
                        width: 1,
                      )
                    ),
                    labelText: 'Email Address',
                    labelStyle: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode?  Color(0xffC0C0C0): Color(0xff767676),
                    )
                  ),
                 ),
                ),
                 SizedBox(height: 12,),
                 SizedBox(
                  width: double.infinity,
                  
                 child: TextField(
                   style: getTextStyle(
                    color: isDarkMode?Color(0xffEBEBEB):Color(0xff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400 
                  ),
                  decoration: InputDecoration(
                     enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffABB7C2),
                        width: 1,
                      )
                    ),
                    labelText: 'Phone Number',
                    labelStyle: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode?  Color(0xffC0C0C0): Color(0xff767676),
                    )
                  ),
                 ),
                ),
                 SizedBox(height: 12,),
                   SizedBox(
                  width: double.infinity,
                 child: TextField(
                   style: getTextStyle(
                    color: isDarkMode?Color(0xffEBEBEB):Color(0xff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400 
                  ),
                  controller: role,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffABB7C2),
                        width: 1,
                      )
                    ),
                    labelText: 'Role',
                    labelStyle: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode?  Color(0xffC0C0C0): Color(0xff767676),
                    )
                  ),
                 ),
                ),
                SizedBox(height: 40,),
                InkWell(
                  onTap: (){
                      if (firstname.text.trim().isNotEmpty && lastname.text.trim().isNotEmpty && role.text.trim().isNotEmpty) {
        controller.addTeamMember(
      firstName: firstname.text.trim(),
      lastName: lastname.text.trim(),
      role: role.text.trim(),
         );  Get.back();

    // Clear fields after adding
       firstname.clear();
       lastname.clear();
       role.clear();
  }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xff003366),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xff003366),
                        width: 1
                      ),
                    ),child: Center(child: Text('Add Team Member',style: getTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffF4F4F4)
                    ),),),
                  ),
                )
              ],
            ),
            ),
          ),
        ),
    );
  }
}