import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/controllers/booking_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/widgets/price_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueDetailsSection extends StatelessWidget {
  const VenueDetailsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The Grand Hall',
                style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Color(0xffEBEBEB) : AppColors.textColor,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  SizedBox(width: 8),
                  Text(
                    '5',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Color(0xffEBEBEB) : Colors.black,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    '(345 reviews)',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDarkMode ? Color(0xffABB7C2) : Color(0xFFABB7C2),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Image.asset(
                    IconPath.locationOnPath,
                    width: 20,
                    height: 20,
                    color: isDarkMode ? Color(0xffD4AF37) : Color(0xFF003366),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'New York, USA',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDarkMode ? Color(0xffEBEBEB) : Color(0xFF333333),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Get.dialog(PriceDialog(controller: Get.find<PriceController>()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Color(0x1AD4AF37) : Color(0x1A003366),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      IconPath.attachmoney,
                      width: 24,
                      height: 24,
                      color: isDarkMode ? Color(0xffD4AF37) : null,
                    ),
                    SizedBox(width: 8),
                    Obx(() {
                      return Get.find<PriceController>().price.value.isNotEmpty
                          ? Text(
                            Get.find<PriceController>().price.value,
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:
                                  isDarkMode
                                      ? Color(0xffD4AF37)
                                      : Color(0xff003366),
                            ),
                          )
                          : Text(
                            'Set Price',
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:
                                  isDarkMode
                                      ? Color(0xffD4AF37)
                                      : Color(0xff003366),
                            ),
                          );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
