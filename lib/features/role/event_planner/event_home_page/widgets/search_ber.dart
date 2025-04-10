import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class SearchBerSection extends StatelessWidget {
  TextEditingController searchTEController = TextEditingController();
   SearchBerSection({
    required this.searchTEController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchTEController,
            decoration: InputDecoration(
              hintText: 'Search venues & services...',
              hintStyle: getTextStyle(color: Colors.grey, fontSize: 14),
              filled: true,
              suffixIcon: Icon(Icons.mic_none),
              fillColor: AppColors.primary,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.iconBackground,
            ),
            child: Icon(Icons.tune, color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
