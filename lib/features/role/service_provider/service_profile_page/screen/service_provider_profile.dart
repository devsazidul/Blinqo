import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/show_profile_popup_menu.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/works_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServiceProviderProfile extends StatelessWidget {
  const ServiceProviderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          reverse: false,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Profile Cover and Avatar
                    Stack(
                      children: [
                        SizedBox(height: 270, width: double.infinity),

                        /// Cover image
                        Image.asset(
                          "assets/images/profile_cover_image.jpeg",
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),

                        /// Three-dot menu and back button
                        Positioned(
                          top: 50,
                          left: 0,
                          right: 0,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white.withAlpha(
                                      100,
                                    ),
                                    child: SvgPicture.asset(
                                      IconPath.arrowLeftAltSvg,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  showPopupMenu(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white.withAlpha(
                                      100,
                                    ),
                                    child: Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Avatar image
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                child: Image.asset(
                                  IconPath.profile01,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    /// name
                    Text(
                      'Ronald Richards',
                      style: getTextStyle(
                        fontSize: 20,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),

                    /// City
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          IconPath.locationOn,
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'New York',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    /// Profession
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          IconPath.camera,
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Photographer',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    /// Button
                    SizedBox(
                      width: 148,
                      child: CustomContinueButton(
                        onTap: () {},
                        title: 'Share Your Work',
                      ),
                    ),
                    SizedBox(height: 40),

                    /// TabBar
                    Align(
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
                    ),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < 3; i++)
                          WorksCardWidget(
                            imagePath:
                                "assets/images/wedding_photography_${i + 1}.jpeg",
                          ),
                        SizedBox(height: 16),
                        // Add more work cards as needed
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 8,
                            children: [
                              Text("Explore All"),
                              Icon(Icons.arrow_right_alt_outlined),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Reviews Tab
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reviews",
                          style: getTextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        for (int i = 0; i < 3; i++)
                          WorksCardWidget(
                            imagePath:
                                "assets/images/wedding_photography_${i + 1}.jpeg",
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
