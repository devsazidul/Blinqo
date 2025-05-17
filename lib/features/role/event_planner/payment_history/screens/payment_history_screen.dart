import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/event_planner/payment_history/widget/payment_appbar.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_payment_history/widgets/payment_transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EvenPaymentHistoryScreen extends StatelessWidget {
  const EvenPaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.put(ProfileController()).isDarkMode.value;
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xff151515) : Color(0xffF4F4F4),
      appBar: PaymentAppBar(title: 'Payment History'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 48),
            // ignore: dead_code
            if (false) _buildNoPaymnetScreen(),
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff003366), Color(0xff0066CC)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPosition(
                        title: 'Total Revenue',
                        value: 1500,
                        fontSize: 32,
                      ),
                      Spacer(),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Color(0xff003366),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Image.asset(ImagePath.move, height: 20),
                            const SizedBox(width: 4),
                            Text(
                              '12.5%',
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),

                  Row(
                    children: [
                      _buildPosition(title: 'This Month', value: 3000),
                      Spacer(),
                      _buildPosition(
                        title: 'Withdrawable Balance',
                        value: 3000,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 34),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < 10; i++) PaymentTransactionCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPosition({
    String title = '',
    double fontSize = 24,
    double value = 0,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) {
    final formater = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 0,
    );
    String formattedValue = formater.format(value);
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xffB0C0D0),
          ),
        ),
        SizedBox(height: 4),
        Text(
          formattedValue,
          style: getTextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildNoPaymnetScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(ImagePath.nopaymentfound, height: 250),
        Text(
          'No Payment History Found',
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff5F5F5F),
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
      ],
    );
  }
}
