import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class WorksReviewsTabBarSection extends StatelessWidget {
  const WorksReviewsTabBarSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
        isScrollable: true,
        dividerHeight: 0,
        tabAlignment: TabAlignment.start,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.buttonColor),
          ),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 1,
        unselectedLabelColor: Color(0xFFABB7C2),
        unselectedLabelStyle: getTextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 20),
        labelColor: AppColors.buttonColor,
        labelStyle: getTextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        tabs: [
          Tab(child: Text('Works')),
          Tab(child: Text('Reviews')),
        ],
      ),
    );
  }
}
