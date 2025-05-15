import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/overview/controller/overview_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddcardScreen extends StatelessWidget {
  AddcardScreen({super.key});

  final OverviewController controller = Get.find<OverviewController>();

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    TextEditingController cardHolderName = TextEditingController();
    TextEditingController cardNumber = TextEditingController();
    return Scaffold(
      backgroundColor:
          isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Card',
                style: getTextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Enter your credit card information into the \nbox below',
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? Color(0xffA1A1A1) : Color(0xff5C5C5C),
                ),
              ),
              SizedBox(height: 24),
              TextField(
                style: TextStyle(
                  color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                ),
                controller: cardHolderName,
                decoration: InputDecoration(
                  labelText: 'Card Holder Name',
                  labelStyle: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff767676),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                style: getTextStyle(
                  color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                ),
                controller: cardNumber,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  labelStyle: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff767676),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: getTextStyle(
                        color:
                            isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                      ),
                      decoration: InputDecoration(
                        hintText: 'MM/YY',
                        hintStyle: TextStyle(
                          color:
                              isDarkMode
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff333333),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      style: getTextStyle(
                        color:
                            isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                      ),
                      decoration: InputDecoration(
                        hintText: 'CVG',
                        hintStyle: TextStyle(
                          color:
                              isDarkMode
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff333333),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              InkWell(
                onTap: () {
                  // controller.confirmPayment();
                  Get.back();
                },
                child: Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff003366),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: getTextStyle(
                        fontWeight: FontWeight.w500,

                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
