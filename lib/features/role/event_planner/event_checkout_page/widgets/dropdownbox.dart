import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class DropdownBox extends StatelessWidget {
  final double width;
  final RxString title;
  final VoidCallback onTap;

  const DropdownBox({
    super.key,
    required this.width,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.42,
      decoration: BoxDecoration(
        color: const Color(0xffE6EBF0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xff003366), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Obx(
              () => Text(
                title.value,
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff333333),
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: onTap,
              child: Image.asset(IconPath.dropdown, height: 7, width: 11),
            ),
          ],
        ),
      ),
    );
  }
}
