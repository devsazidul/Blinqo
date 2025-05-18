import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/team/controller/teamcontroller.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/my_team_tab_screen.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/schedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleAndTeamScreen extends StatelessWidget {
  final String venueId;
  const ScheduleAndTeamScreen({super.key, required this.venueId});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final TeamControllerGetx teamControllerGetx = Get.put(TeamControllerGetx());

    Color activeColor = isDarkMode ? Color(0xffD4AF37) : Color(0xff003366);
    const Color inactiveColor = Color(0xffA1A1A1);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:
            isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => TabBar(
                  onTap: teamControllerGetx.changeTab,
                  tabs: [
                    Tab(
                      child: Text(
                        'Schedule',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              teamControllerGetx.selectedIndex.value == 0
                                  ? activeColor
                                  : inactiveColor,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'My Team',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              teamControllerGetx.selectedIndex.value == 1
                                  ? activeColor
                                  : inactiveColor,
                        ),
                      ),
                    ),
                  ],
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 3, color: activeColor),
                    insets: EdgeInsets.symmetric(horizontal: Get.width * 0.35),
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  switch (teamControllerGetx.selectedIndex.value) {
                    case 0:
                      return Schedule(venueId: venueId);
                    case 1:
                      return MyTeamTab(venueId: venueId);
                    default:
                      return const SizedBox();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
