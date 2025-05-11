
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/review_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewListWidget extends StatelessWidget {
  ReviewListWidget({super.key});

  final ReviewController controller = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.put(SpProfileController()).isDarkMode.value;
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.only(bottom: 80),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.filteredReviews.length,
        itemBuilder: (context, index) {
          final review = controller.filteredReviews[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          IconPath.profile01,
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.userName,
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? AppColors.borderColor2 : Color(0xff333333),
                            ),
                          ),

                          /// Rating
                          Row(
                            children: List.generate(5, (i) {
                              return Icon(
                                i < review.rating.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 16,
                              );
                            }),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        review.displayDate,
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffC0C0C0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    review.comment,
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDarkMode ? Color(0xffA1A1A1): Color(0xff5C5C5C),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
