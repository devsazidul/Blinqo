import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/screens/v_payment_option_screen.dart';

import 'package:blinqo/features/role/venue_owner/payment_page/screens/v_thank_you_screen.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/widgets/v_payment_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VPaymentMethod extends StatelessWidget {
  const VPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FAFB),
      appBar: VPaymentAppBar(title: 'Payment Option'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 60),
              Image.asset(ImagePath.nopaymentfound, height: 250),
              Text(
                'No Payment Method Found',
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'You can add or edit payment during checkout',
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5F5F5F),
                ),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Get.to(
                  VPaymentOptionScreen(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 400),
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration:BoxDecoration(
                    color: Color(0xffFEFEFE),
                    borderRadius: BorderRadius.circular(15),
                    border:  Border.all(
                      color: Color(0xffE4E4E7),
                      width: 1
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: Image.asset(
                        IconPath.addicon,
                        width: 44,
                        height: 44,
                      ),
                      title: Text('Add a payment method'),
                      titleTextStyle: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff171725),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
