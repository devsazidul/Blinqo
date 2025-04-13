import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/review_controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/rating_summary.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/ratting_distribution_widget.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/review_filter_star_buttons.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/review_list_widget.dart';
import 'package:flutter/material.dart';


class ReviewsTabViewWidget extends StatelessWidget {
  const ReviewsTabViewWidget({
    super.key,
    required this.controller,
  });

  final ReviewController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.star, color: Colors.amber, size: 22.5),
    
          /// Rating Summary Section
          RatingSummary(controller: controller),
          SizedBox(height: 16),
    
          /// Rating Distribution
          RattingDistributionWidget(controller: controller),
          SizedBox(height: 16),
    
          /// Leave a Review Text Field
          TextFormField(
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: "Review",
              hintText: "leave a review",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(height: 16),
    
          /// Star buttons
          ReviewFilterStarButtons(),
          SizedBox(height: 20),
    
          ///
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Review",
              style: getTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // SizedBox(height: 16),
          // Reviews List
          ReviewListWidget(),
        ],
      ),
    );
  }
}
