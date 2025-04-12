import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
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
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Profile Cover and Avatar
                    Stack(
                      children: [
                        SizedBox(height: 270, width: double.infinity),
                        Image.asset(
                          "assets/images/profile_cover_image.jpeg",
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),

                        /// back button
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
                                  _showPopupMenu(context);
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
                    Text(
                      'Ronald Richards',
                      style: getTextStyle(
                        fontSize: 20,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    // City
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
                    // Profession
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
                    // Button
                    SizedBox(
                      width: 148,
                      child: CustomContinueButton(
                        onTap: () {},
                        title: 'Share Your Work',
                      ),
                    ),
                    SizedBox(height: 40),
                    // TabBar
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
          body: Padding(
            padding: EdgeInsets.zero,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                // Works Tab
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < 3; i++)
                          ProfileWorkCardWidget(
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
                          ProfileWorkCardWidget(
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

  void _showPopupMenu(BuildContext context) {
    // Show the popup menu
    showMenu(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(100, 50, 0, 0),
      items: [
        _buildPopupMenuItem(
          "Edit Profile",
          "Edit Profile",
          context,
          iconPath: IconPath.editPencil,
        ),
        _buildPopupMenuItem(
          "View As",
          "view_as",
          context,
          iconPath: IconPath.viewAs,
        ),
        _buildPopupMenuItem(
          "Settings",
          "settings",
          context,
          iconPath: IconPath.settings,
        ),
        _buildPopupMenuItem(
          "Go Pro",
          "go_pro",
          context,
          iconPath: IconPath.goPro,
        ),
      ],
    );
  }

  // Helper method to build a PopupMenuItem with an icon and a Divider
  PopupMenuItem<String> _buildPopupMenuItem(
    String text,
    String value,
    BuildContext context, {
    String iconPath = IconPath.editPencil,
    bool addDivider = true,
  }) {
    return PopupMenuItem<String>(
      value: value,
      // Set padding to zero since we're handling it in the Container
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Wrap in InkWell to show ripple effect
          InkWell(
            onTap: () {
              // Close the menu
              Navigator.pop(context, value);
            },
            // Make the InkWell take the full width
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  SizedBox(width: 10),

                  // Icon prefix
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Image.asset(
                      iconPath,
                      width: 15,
                      color: AppColors.textColor,
                    ),
                    // child: Icon(icon, size: 20, color: Colors.black87),
                  ),

                  // Menu item text
                  Text(
                    text,
                    style: getTextStyle(
                      color: Color(0xFF003285),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      lineHeight: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Add divider if needed
          if (addDivider)
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFEEEEEE), // Light gray color
              endIndent: 0,
              indent: 0,
            ),
        ],
      ),
    );
  }
}

class ProfileWorkCardWidget extends StatelessWidget {
  const ProfileWorkCardWidget({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Adds shadow for the card effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Container(
        height: 150, // Adjust height as needed
        width: double.infinity, // Adjust width as needed

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(imagePath), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Overlay for better text readability
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(
                      alpha: 0.5,
                    ), // Top is slightly darker
                    Colors.black.withAlpha(50), // Bottom is darker
                  ],
                ),
              ),
            ),
            // Text content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'WEDDING PHOTOGRAPHY',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ronald Richards',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFD4AF37),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
