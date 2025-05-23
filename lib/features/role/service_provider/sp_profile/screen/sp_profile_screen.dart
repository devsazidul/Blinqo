import 'package:blinqo/core/common/widgets/custom_continue_button.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_profile_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_review_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/sp_share_work_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/widget/profile_cover_image_and_avater.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/widget/profile_summary_section.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/widget/sp_review_tab_view_widget.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/widget/sp_works_tab_view_widget.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/widget/works_reviews_tab_bar_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpProfileScreen extends StatelessWidget {
  static const String name = '/sp_profile_home';

  SpProfileScreen({super.key});
  final SpProfileController spProfileController = Get.put(
    SpProfileController(),
  );

  @override
  Widget build(BuildContext context) {
    final SpReviewController controller = Get.put(SpReviewController());

    return Scaffold(
      body: Obx(() {
        return ColoredBox(
          color:
              spProfileController.isDarkMode.value
                  ? Color(0xff151515)
                  : Color(0xffF4F4F4),
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
                        //* ------------ Profile Cover and Avatar ------------
                        ProfileCoverImageAndAvatar(),
                        SizedBox(height: 12),

                        /// Profile summary section
                        ProfileSummarySection(),

                        /// Button
                        SizedBox(
                          width: 148,
                          child: CustomContinueButton(
                            horizontalPadding: 10,
                            onPress: () {
                              Get.to(() => SpShareWorkScreen());
                              // Navigator.pushNamed(
                              //   context,
                              //   SpShareWorkScreen.name,
                              // );
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
                    SpWorksTabViewWidget(),

                    /// Reviews Tab
                    SpReviewsTabViewWidget(controller: controller),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
