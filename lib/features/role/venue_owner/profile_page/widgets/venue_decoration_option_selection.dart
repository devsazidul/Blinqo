import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionSection extends StatelessWidget {
  final String title;
  final List<String> options;
  final RxList<String> selectedOptions;
  final Function(String, List<String>) onToggle;

  const OptionSection({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOptions,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xff333333),
          ),
        ),
        Wrap(
          spacing: 10,
          runSpacing: 0.0,
          children:
              options.map((option) {
                return Obx(
                  () => SizedBox(
                    // ass need space not fix
                    width:  MediaQuery.of(context).size.width * 0.4,
                    child: Row(
                      children: [
                        Checkbox(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          value: selectedOptions.contains(option),
                          onChanged: (bool? value) {
                            onToggle(option, selectedOptions);
                          },
                          activeColor: Color(0xff003366),
                          side: BorderSide(color: Color(0xff003366), width: 1),
                        ),
                        SizedBox(width: 8),
                        Text(
                          option[0].toUpperCase() + option.substring(1).toLowerCase(),
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff333333),
                          ),
                        ),
                      ],
                    ),
                  )
                );
              }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
