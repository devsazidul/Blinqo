import 'package:blinqo/core/common/widgets/custom_appbar_widget.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/invitation/controller/guest_list_controller.dart';
import 'package:blinqo/features/role/event_planner/invitation/widgets/guest_list_header.dart';
import 'package:blinqo/features/role/event_planner/invitation/widgets/guest_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestListScreen extends StatelessWidget {
  static const String routeName = '/guest_list_screen';
  const GuestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final guestListController = Get.put(GuestListController());
    return Scaffold(
      backgroundColor:
          Get.find<ProfileController>().isDarkMode.value
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: CustomAppBarWidget(
        onPressed: () => Get.back(),
        title: 'Guest List',
        actions: [
          IconButton(
            icon: Image.asset(IconPath.filterIcon, width: 16, height: 16),
            onPressed: () {
              // show filter menu buttons
              _showFilterMenu(context, guestListController);
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: ColoredBox(
        color:
            Get.find<ProfileController>().isDarkMode.value
                ? Color(0xff1E1E1E)
                : Color(0xfff4f4f4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24),

            //*-- Guest List Header
            GuestListHeader(),

            SizedBox(height: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GetBuilder<GuestListController>(
                  builder: (controller) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: controller.guestList.length,
                      separatorBuilder:
                          (context, index) => SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        return GuestListItem(item: controller.guestList[index]);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterMenu(BuildContext context, GuestListController controller) {
    showMenu(
      color: Color(0xffDEEAFF),
      context: context,
      position: RelativeRect.fromLTRB(100, 50, 0, 0),

      // aignment
      items: [
        PopupMenuItem(
          value: "All",
          child: Text('All'),
          onTap: () {
            controller.filterGuestList('All');
          },
        ),
        PopupMenuItem(
          value: "Accepted",
          child: Text('Accepted'),
          onTap: () {
            controller.filterGuestList('Accepted');
          },
        ),
        PopupMenuItem(
          value: "Pending",
          child: Text('Pending'),
          onTap: () {
            controller.filterGuestList('Pending');
          },
        ),
        PopupMenuItem(
          value: "Denied",
          child: Text('Denied'),
          onTap: () {
            controller.filterGuestList('Denied');
          },
        ),
      ],
    );
  }
}
