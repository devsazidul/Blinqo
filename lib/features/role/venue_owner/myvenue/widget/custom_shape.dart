import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';

class CustomShapeTag extends StatelessWidget {
  final String label;
  final double height;
  final double width;
  final Widget? icon; // Optional icon

  const CustomShapeTag({
    super.key,
    required this.label,
    required this.height,
    required this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withValues(alpha: .1),
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(34),
          color: isDarkMode ? Color(0xff32383D) : Color(0xffFFFFFF),
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 2)],
              Text(
                label,
                style: getTextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
