import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/profile/widget/f_custom_button.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/service_provider/ep_service_provider_booking_screen1.dart';
import 'package:blinqo/features/role/event_planner/service_provider/controller/review_controller.dart';
import 'package:blinqo/features/role/event_planner/service_provider/widget/profile_cover_image_and_avater.dart';
import 'package:blinqo/features/role/event_planner/service_provider/widget/profile_summary_section.dart';
import 'package:blinqo/features/role/event_planner/service_provider/widget/review_tab_view_widget.dart';
import 'package:blinqo/features/role/event_planner/service_provider/widget/works_reviews_tab_bar_section.dart';
import 'package:blinqo/features/role/event_planner/service_provider/widget/works_tab_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpServiceProviderProfile extends StatelessWidget {
  static const String name = '/event-planner/service-provider-profile';

  const EpServiceProviderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final EpSpReviewController controller = Get.put(EpSpReviewController());
    final ProfileController profileController = Get.find<ProfileController>();
    double screenHeight = MediaQuery.of(context).size.height;
    double mediafontsized = (screenHeight < 700) ? 13 : 16;
    return Scaffold(
      body: Obx(() {
        return ColoredBox(
          color:
              profileController.isDarkMode.value
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
                        EpSpProfileCoverImageAndAvatar(),
                        SizedBox(height: 12),
                        EpSpProfileSummarySection(
                          isDarkMode: profileController.isDarkMode.value,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45.0),
                          child: Row(
                            spacing: 8,
                            children: [
                              Expanded(
                                child: FCustomButton(
                                  backgroundColor:
                                      profileController.isDarkMode.value
                                          ? AppColors.buttonColor.withValues(
                                            alpha: .10,
                                          )
                                          : AppColors.buttonColor2.withValues(
                                            alpha: .10,
                                          ),
                                  child: Obx(() {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      spacing: 8,
                                      children: [
                                        Image.asset(
                                          IconPath.messageicon,
                                          width: 20,
                                          height: 18,
                                          color:
                                              profileController.isDarkMode.value
                                                  ? AppColors.buttonColor
                                                  : AppColors.buttonColor2,
                                        ),
                                        Text(
                                          "Message",
                                          style: getTextStyle(
                                            fontSize: mediafontsized,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                profileController
                                                        .isDarkMode
                                                        .value
                                                    ? AppColors.buttonColor
                                                    : AppColors.buttonColor2,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                              Expanded(
                                child: FCustomButton(
                                  backgroundColor:
                                      profileController.isDarkMode.value
                                          ? AppColors.buttonColor
                                          : AppColors.buttonColor2,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(EpServiceProviderBookingScreen1());
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      spacing: 10,
                                      children: [
                                        Image.asset(
                                          IconPath.handshake,
                                          width: 20,
                                          height: 18,
                                          color: AppColors.primary,
                                        ),
                                        Text(
                                          "Hire",
                                          style: getTextStyle(
                                            fontSize: mediafontsized,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 40),

                        /// TabBar
                        EpSpWorksReviewsTabBarSection(),
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
                    EpSpWorksTabViewWidget(),

                    /// Reviews Tab
                    EpSpReviewsTabViewWidget(controller: controller),
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
