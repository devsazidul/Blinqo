import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/invitation/widgets/guest_list_count.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestListHeader extends StatelessWidget {
  const GuestListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:
                Get.find<ProfileController>().isDarkMode.value
                    ? Color(0xff32383D)
                    : Color(0xffFBF7EB),
            borderRadius: BorderRadius.all(Radius.circular(28)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GuestListCount(
                title: "Invited ",
                count: "200",
                color:
                    Get.find<ProfileController>().isDarkMode.value
                        ? Color(0xffebebeb)
                        : Color(0xff333333),
              ),
              GuestListCount(
                title: "Accepted ",
                count: "100",
                color: Color(0xff23AE01),
              ),
              GuestListCount(
                title: "Denied ",
                count: "70",
                color: Color(0xffF00000),
              ),
              GuestListCount(
                title: "Pending ",
                count: "30",
                color: Color(0xffD4AF37),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
