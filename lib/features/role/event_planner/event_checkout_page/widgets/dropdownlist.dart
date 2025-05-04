import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';

class DropdownList extends StatelessWidget {
  final double width;
  final List<String> options;
  final Function(String) onSelect;

  const DropdownList({
    super.key,
    required this.width,
    required this.options,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children:
            options
                .map(
                  (option) => Column(
                    children: [
                      _buildDropdownItem(option, onSelect),
                      if (option != options.last)
                        const Divider(height: 1, color: Color(0xffEEEEEE)),
                    ],
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildDropdownItem(String task, Function(String) onSelect) {
    return InkWell(
      onTap: () => onSelect(task),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Text(
              task,
              style: getTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xff003285),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
