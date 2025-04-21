import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/core/utils/helpers/app_helper.dart';
import 'package:blinqo/features/role/event_planner/invitation/screens/edit_invitation_card_screen.dart';
import 'package:blinqo/features/role/event_planner/invitation/widgets/custom_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InvitationCardScreen extends StatelessWidget {
  const InvitationCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBarWidget(
        title: 'Invitation Card',
        actions: [
          IconButton(
            icon: Image.asset(IconPath.editPancilOnFram, width: 24, height: 24),
            onPressed: () {
              Get.to(() => EditInvitationCardScreen());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: AppHelperFunctions.screenWidth(),
              height: AppHelperFunctions.screenWidth() / 0.5574,
              // height: min(
              //   MediaQuery.of(context).size.height * 0.8,
              //   720,
              // ), // Minimum height of 700
              padding: EdgeInsets.symmetric(
                horizontal: AppHelperFunctions.screenWidth() * 0.20,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagePath.borderImage),

                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Jhon & Jeni Wedding",
                          style: GoogleFonts.risque(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff955498),
                          ),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      ),

                      ClipOval(
                        // borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          ImagePath.invitationAvatar,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  // details
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            "We are getting married on September 15, 2027!!\n",
                        style: GoogleFonts.rochester(
                          fontSize: 18,
                          color: Color(0xff955498),
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text:
                                "Please reserve this day for us so we can celebrate with you.\nWe are looking forward to seeing you!\nMore details will follow with the invitation.",
                            style: TextStyle(color: Color(0xff333333)),
                          ),
                          TextSpan(text: "\nJhon & Jen"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 40,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFF2D55),
                  foregroundColor: Colors.white,
                  minimumSize: Size(AppHelperFunctions.screenWidth(), 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    Text("Share Invitation"),
                    Icon(Icons.share_outlined),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
