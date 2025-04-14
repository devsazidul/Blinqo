import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/review_controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/share_work_page.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/profile_cover_image_and_avater.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/profile_summary_section.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/review_tab_view_widget.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/works_reviews_tab_bar_section.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/works_tab_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceProviderProfile extends StatelessWidget {
  const ServiceProviderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final ReviewController controller = Get.put(ReviewController());
    return Scaffold(
      body: ColoredBox(
        color: Color(0xffF4F4F4),
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            reverse: false,
            headerSliverBuilder: (
              BuildContext context,
              bool innerBoxIsScrolled,
            ) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // Profile Cover and Avatar
                      ProfileCoverImageAndAvater(),
                      SizedBox(height: 12),

                      /// Profile summary section
                      ProfileSummarySection(),

                      /// Button
                      SizedBox(
                        width: 148,
                        child: CustomContinueButton(
                          onTap: () {
                            Get.to(SpShareWorkPage());
                          },
                          title: 'Share Your Work',
                        ),
                      ),
                      SizedBox(height: 40),

                      /// TabBar
                      WorksReviewsTabBarSection(),
                    ],
                  ),
                ),
              ];
            },

            /// Tabbar view
            body: Padding(
              padding: EdgeInsets.zero,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  /// Works Tab
                  WorksTabViewWidget(),

                  /// Reviews Tab
                  ReviewsTabViewWidget(controller: controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
