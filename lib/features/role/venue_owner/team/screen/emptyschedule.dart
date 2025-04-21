import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/team/controller/teamcontroller.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/myteam.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/schedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Emptyschedule extends StatelessWidget {
  const Emptyschedule({super.key});

  @override
  Widget build(BuildContext context) {
    final TeamControllerGetx teamControllerGetx = Get.put(TeamControllerGetx());

    const Color activeColor = Color(0xff003366);
    const Color inactiveColor = Color(0xffA1A1A1);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => TabBar(
                onTap: teamControllerGetx.changeTab,
                tabs: [
                  Tab(
                    child: Text(
                      'Schedule',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: teamControllerGetx.selectedIndex.value == 0
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
                        color: teamControllerGetx.selectedIndex.value == 1
                            ? activeColor
                            : inactiveColor,
                      ),
                    ),
                  ),
                ],
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3, color: activeColor),
                  insets: EdgeInsets.symmetric(horizontal: -30),
                ),
              )),
              const Divider(height: 1, thickness: 1),
              Expanded(
                child: Obx(() {
                  switch (teamControllerGetx.selectedIndex.value) {
                    case 0:
                      return const Schedule();
                    case 1:
                      return const Myteam();
                    default:
                      return const SizedBox();
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
