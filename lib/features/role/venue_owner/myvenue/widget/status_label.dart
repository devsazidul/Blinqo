import 'package:flutter/cupertino.dart';

import '../../../../../core/common/styles/global_text_style.dart';

class StatusLabel extends StatelessWidget {
  final Color color;
  final String label;

  const StatusLabel({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: getTextStyle(fontWeight: FontWeight.w400, fontSize: 14),
        ),
      ],
    );
  }
}
