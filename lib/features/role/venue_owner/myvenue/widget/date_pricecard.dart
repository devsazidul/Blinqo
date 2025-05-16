import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePriceCard extends StatelessWidget {
  final ValueNotifier<List<DateTime>> selectedDatesNotifier;
  final TextEditingController priceController;
  final double screenHeight;
  final double screenWidth;
  final int price;

  const DatePriceCard({
    super.key,
    required this.selectedDatesNotifier,
    required this.priceController,
    required this.screenHeight,
    required this.screenWidth,
    required this.price,
  });

  String _getMonthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month];
  }

  String _formatDates(List<DateTime> dates) {
    if (dates.isEmpty) return 'No date selected';
    if (dates.length == 1) {
      final date = dates.first;
      return '${date.day} ${_getMonthName(date.month)} ${date.year}';
    }
    // For multiple dates, show a range or list
    dates.sort(); // Ensure dates are sorted
    final start = dates.first;
    final end = dates.last;
    return '${start.day} ${_getMonthName(start.month)} ${start.year} - ${end.day} ${_getMonthName(end.month)} ${end.year}';
  }

  void _saveChanges() {
    final priceText = priceController.text.trim();
    if (priceText.isEmpty || int.tryParse(priceText) == null) {
      Get.snackbar('Error', 'Please enter a valid price');
      return;
    }
    final newPrice = int.parse(priceText);
    // final controller = Get.find<VenueDetailsController>();
    // Assuming an updatePrice method exists in VenueDetailsController
    // controller.updatePrice(newPrice);
    Get.snackbar('Success', 'Price updated to \$$newPrice');
  }

  @override
  Widget build(BuildContext context) {

    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    
    // Initialize priceController with the venue's price
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (priceController.text.isEmpty && price > 0) {
        priceController.text = price.toString();
      }
    });


    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xff32383D) : const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Selected Date Row
            Row(
              children: [
                Text(
                  'Selected Date(s)',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff333333),
                  ),
                ),
                const Spacer(),
                ValueListenableBuilder<List<DateTime>>(
                  valueListenable: selectedDatesNotifier,
                  builder: (context, selectedDates, _) {
                    return Text(
                      _formatDates(selectedDates),
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,


                        color: isDarkMode ? const Color(0xff34C759) : const Color(0xff19480B),

                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            /// Price Row
            Row(
              children: [
                Text(
                  'Price',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,


                    color: isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff333333),

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
                      color: isDarkMode ? const Color(0xffAFB1B6) : const Color(0xffABB7C2),
                    ),
                  ),
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    style: getTextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: isDarkMode ? const Color(0xff34C759) : const Color(0xff19480B),
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            /// Save Button
            Center(

 

              child: GestureDetector(
                onTap: _saveChanges,
                child: Container(
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: isDarkMode ? const Color(0xffD4AF37) : const Color(0xff003366),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Save Changes',
                      style: getTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: isDarkMode ? const Color(0xffD4AF37) : const Color(0xff003366),
                      ),
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