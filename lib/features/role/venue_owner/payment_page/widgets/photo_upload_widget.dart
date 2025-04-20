import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoUploadWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const PhotoUploadWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return GestureDetector(
      onTap: onTap,
      child: ColoredBox(
        color: isDarkMode ? Color(0xff32383D) : Color(0xffFAFAFA),
        child: SizedBox(
          width: double.infinity,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(8),
            dashPattern: [4, 4],
            strokeCap: StrokeCap.round,
            strokeWidth: 1.5,
            padding: EdgeInsets.all(16),
            color: Color(0xffE5E5E5),
            child: Center(
              child: Column(
                children: [
                  Image.asset(IconPath.niduploadlogo, height: 32),
                  SizedBox(height: 12),
                  Text(
                    'Click to upload',
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff0EA5E9),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'JPG, JPEG, PNG less than 1MB',
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffA3A3A3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
