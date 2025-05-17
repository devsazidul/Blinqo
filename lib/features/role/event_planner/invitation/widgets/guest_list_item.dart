import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestListItem extends StatelessWidget {
  const GuestListItem({super.key, required this.item});

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        color:
            Get.find<ProfileController>().isDarkMode.value
                ? Color(0xff32383D)
                : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Color(0xffD9D9D9),
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item['name'] ?? 'Unknown', // Fallback value for 'name'
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color:
                      Get.find<ProfileController>().isDarkMode.value
                          ? Color(0xffEBEBEB)
                          : Color(0xff000003),
                ),
              ),
              Text(
                item['address'] ?? 'No address', // Fallback value for 'address'
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff8D8D8D),
                ),
              ),
            ],
          ),

          Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(""),
              Text(
                item['status'] ?? 'Unknown', // Fallback value for 'status'
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color:
                      item['status'] == 'Accepted'
                          ? Color(0xff23AE01)
                          : item['status'] == 'Pending'
                          ? Color(0xffD4AF37)
                          : Color(0xffF00000),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
