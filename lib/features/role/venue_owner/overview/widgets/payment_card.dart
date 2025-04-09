import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../screen/addcard_screen.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85, // 85% of screen width
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff003366).withOpacity(0.3),
            Color(0xff0066CC).withOpacity(0.3),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: ClipOval(
                child: Container(
                  height: 24,
                  width: 24,
                  color: Colors.indigo,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => AddcardScreen());
                    },
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Please Add Payment Details',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
