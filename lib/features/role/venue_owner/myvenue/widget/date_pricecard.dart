import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/common/styles/global_text_style.dart';

class DatePriceCard extends StatelessWidget {
  final ValueNotifier<List<DateTime>> selectedDatesNotifier;
  final TextEditingController priceController;
  final double screenHeight;
  final double screenWidth;

  const DatePriceCard({
    super.key,
    required this.selectedDatesNotifier,
    required this.priceController,
    required this.screenHeight,
    required this.screenWidth,
  });

  String _getMonthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20  ,vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Selected Date Row
            Row(
              children: [
                Text(
                  'Selected Date',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff333333),
                  ),
                ),
                const Spacer(),
                ValueListenableBuilder<List<DateTime>>(
                  valueListenable: selectedDatesNotifier,
                  builder: (context, selectedDates, _) {
                    if (selectedDates.isEmpty) {
                      return Text(
                        'No date selected',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff333333),
                        ),
                      );
                    }
                    final selected = selectedDates.first;
                    final formatted =
                        '${selected.day} ${_getMonthName(selected.month)} ${selected.year}';

                    return Text(
                      formatted,
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff19480B),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// Price Row
            Row(
              children: [
                Text(
                  'Price',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff333333),
                  ),
                ),
                const Spacer(),
                Container(
                  height: screenHeight * 0.036,
                  width: screenWidth * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xffABB7C2),
                    ),
                  ),
                  child: TextField(
                    controller: priceController,
                    style: getTextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: const Color(0xff19480B),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Price',
                      labelStyle: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff767676),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// Save Button
            Center(
              child: Container(
                height: screenHeight * 0.06,
                width: screenWidth * 0.50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 1,
                    color: const Color(0xff003366),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Save Changes',
                    style: getTextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: const Color(0xff003366),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
