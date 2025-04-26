import 'dart:ui';

import 'package:blinqo/core/common/widgets/custom_appbar_widget.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/core/utils/helpers/app_helper.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/profile/widget/f_custom_button.dart';
import 'package:blinqo/features/role/event_planner/invitation/screens/edit_invitation_card_screen.dart';
import 'package:blinqo/features/role/event_planner/invitation/screens/guest_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InvitationCardScreen extends StatelessWidget {
  const InvitationCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.find<ProfileController>().isDarkMode.value
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: CustomAppBarWidget(
        title: 'Invitation Card',
        actions: [
          IconButton(
            icon: Image.asset(
              IconPath.editPancilOnFram,
              width: 24,
              height: 24,
              color:
                  Get.find<ProfileController>().isDarkMode.value
                      ? Color(0xffD4AF37)
                      : null,
            ),
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
              child: FCustomButton(
                onPressed: () {
                  _showBlurredDialog(context);

                  // Get.dialog(
                  //   barrierColor: Colors.transparent.withValues(),
                  //   Dialog(
                  //     insetPadding: EdgeInsets.zero,
                  //     backgroundColor: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(14),
                  //     ),
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         SizedBox(height: 16),
                  //         Image.network(
                  //           "https://s3-alpha-sig.figma.com/img/745a/740e/1df6209b7348876fd5caeabc40134c47?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Kl6FEco0-0babaW9dSJlR351yRCs~-DCTDh6kDGDv0-W4NIbacvenGkmS910qSQaLflRDdLIvgQ2h9Oux6eRHsh7EN9v6xP9hjm1A9TUi2Bmd5hHVpuAR7Vs6eUXDyzvWpEO~KFXwAdSGom2yDYpEIB9r4hw~U~LeovHvv55NiSh8kxtgnH1tJAv~0SkcQIAkvp~YJ1RNKbSJ~fbnFXCsRso5tHWCUvDZaBd1MlPSlNfiMlNoMc7lfYDR-miCTZtEFyRPJndDIV~eJyVtVosGUnUXqCP2P6mqc0lCHVPBVEHyut-71ln46-Yky0YqAXv926swZEfkZvzoqqjcvQYPQ__",
                  //           width: 217,
                  //           height: 217,
                  //         ),
                  //         SizedBox(height: 32),
                  //         SizedBox(
                  //           width: 136,
                  //           child: EpCustomButton(
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               spacing: 16,
                  //               children: [
                  //                 Text("Share"),
                  //                 Icon(Icons.share_outlined),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //         SizedBox(height: 32),
                  //       ],
                  //     ),
                  //   ),
                  // );
                },
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

  void _showBlurredDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Blurred Dialog",
      barrierColor: Colors.black.withAlpha(180), // Semi-transparent background
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Apply blur effect
          child: Center(
            child: Dialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 16),
                  Image.network(
                    "https://s3-alpha-sig.figma.com/img/745a/740e/1df6209b7348876fd5caeabc40134c47?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Kl6FEco0-0babaW9dSJlR351yRCs~-DCTDh6kDGDv0-W4NIbacvenGkmS910qSQaLflRDdLIvgQ2h9Oux6eRHsh7EN9v6xP9hjm1A9TUi2Bmd5hHVpuAR7Vs6eUXDyzvWpEO~KFXwAdSGom2yDYpEIB9r4hw~U~LeovHvv55NiSh8kxtgnH1tJAv~0SkcQIAkvp~YJ1RNKbSJ~fbnFXCsRso5tHWCUvDZaBd1MlPSlNfiMlNoMc7lfYDR-miCTZtEFyRPJndDIV~eJyVtVosGUnUXqCP2P6mqc0lCHVPBVEHyut-71ln46-Yky0YqAXv926swZEfkZvzoqqjcvQYPQ__",
                    width: 217,
                    height: 217,
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width: 136,
                    child: FCustomButton(
                      onPressed: () {
                        Get.to(() => GuestListScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Share"),
                          SizedBox(width: 8),
                          Icon(Icons.share_outlined),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
