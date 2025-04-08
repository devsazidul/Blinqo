import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/venue_owner/overview/controller/overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddcardScreen extends StatelessWidget {
  AddcardScreen({super.key});

  final OverviewController controller = Get.put(OverviewController());

  @override
  Widget build(BuildContext context) {
    TextEditingController CardHolderName = TextEditingController();
    TextEditingController CardNumber = TextEditingController();
    return Scaffold(
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
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Enter your credit card information into the \nbox below',
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5C5C5C),
                ),
              ),
              SizedBox(height: 24),
              TextField(
                controller: CardHolderName,
                decoration: InputDecoration(
                  labelText: 'Card Holder Name',
                  labelStyle: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff767676),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: CardNumber,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  labelStyle: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff767676),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(hintText: 'MM/YY'),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(hintText: 'CVG'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              InkWell(
                onTap: () {},
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
