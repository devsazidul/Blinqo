import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/device/device_utility.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/work_post_controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/show_profile_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkPostScreen extends StatelessWidget {
  final WorkPostController _workPostController = Get.put(WorkPostController());

  WorkPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeMode =
    //       controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
    // List<String> imageUrls = [
    //   'assets/images/wedding_photography_1.jpeg',
    //   'assets/images/wedding_photography_2.jpeg',
    //   'assets/images/wedding_photography_3.jpeg',
    //   'assets/images/wedding_photography_1.jpeg',
    //   'assets/images/wedding_photography_2.jpeg',
    //   'assets/images/wedding_photography_3.jpeg',
    //   'assets/images/wedding_photography_1.jpeg',
    //   'assets/images/wedding_photography_2.jpeg',
    //   'assets/images/wedding_photography_3.jpeg',
    // ];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(context, ThemeMode.light),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Birthday Party Photography',
                  style: getTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.buttonColor2,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF5C5C5C),
                  ),
                ),
                SizedBox(height: 12),

                /// Like Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '33',
                      // '${post.likes}',
                      style: getTextStyle(
                        fontSize: 14,
                        color: AppColors.textColor,
                        // lineHeight: 1
                      ),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        // _workPostController.toggleLike(index);
                      },
                      child: Column(
                        children: [
                          Image.asset(IconPath.likeIcon, width: 20),
                          SizedBox(height: 6),
                        ],
                      ),
                      // child: Icon(
                      //   Icons.favorite,
                      //   // post.isLiked ? Icons.favorite : Icons.favorite_border,
                      //   // color: post.isLiked ? Colors.red : Colors.grey,
                      //   color: AppColors.buttonColor2,
                      // ),
                    ),
                  ],
                ),
                SizedBox(height: 32),

                /// Image Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// First Column
                    Column(
                      children: [
                        for (
                          int i = 0;
                          i < _workPostController.imageUrls.length;
                          i++
                        )
                          if (i % 2 == 0)
                            GestureDetector(
                              onTap: () {
                                print(
                                  'Image tapped: ${_workPostController.imageUrls[i]}',
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Container(
                                  width:
                                      AppDeviceUtility.getScreenWidth(context) /
                                          2 -
                                      24,
                                  height: 230,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        _workPostController.imageUrls[i],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),

                    /// Second Column
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        for (
                          int i = 0;
                          i < _workPostController.imageUrls.length;
                          i++
                        )
                          if (i % 2 == 1)
                            GestureDetector(
                              onTap: () {
                                print(
                                  'Image tapped: ${_workPostController.imageUrls[i]}',
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Container(
                                  width:
                                      AppDeviceUtility.getScreenWidth(context) /
                                          2 -
                                      24,
                                  height: 230,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        _workPostController.imageUrls[i],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ), // body: Row(
    );
  }

  AppBar _buildAppBar(BuildContext context, ThemeMode themeMode) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      forceMaterialTransparency: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            backgroundColor:
                themeMode == ThemeMode.dark
                    ? Color(0xFFD9D9D9).withAlpha(40)
                    : const Color(0xFFD9D9D9),
            child: Image.asset(
              IconPath.arrowLeftAlt,
              color:
                  themeMode == ThemeMode.dark
                      ? Colors.white
                      : AppColors.textColor,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            showPopupMenu(context);
          },
          icon: Image.asset(
            IconPath.moreVert,
            height: 22.5,
            color:
                themeMode == ThemeMode.dark
                    ? AppColors.backgroundColor
                    : AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
