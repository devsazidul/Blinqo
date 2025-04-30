import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_appbar_widget.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PickColorController femaleColorController = Get.put(
      PickColorController(),
    );
    final bool isDarkMode = Get.find<ProfileController>().isDarkMode.value;
    final List<int> ids = [3, 4, 5, 9];
    final bool isFemale = femaleColorController.isFemale.value;
    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: CustomAppBarWidget(
        onPressed: () {
          Get.back();
        },
        title: "Notification",
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(IconPath.moreVert, width: 24, height: 24),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: 15,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            tileColor:
                ids.contains(index)
                    ? (isDarkMode
                        ? Color(0xff32383D)
                        : isFemale
                        ? (femaleColorController.selectedColor)
                        : Color(0xffDEEAFF))
                    : null,
            leading: CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
              ),
            ),
            title: Text(
              "Notification $index",
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color:
                    !ids.contains(index) && isDarkMode
                        ? Color(0xffEBEBEB)
                        : Color(0xff333333),
              ),
            ),
            subtitle: Text(
              "10 min Ago",
              style: getTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff8D8D8D),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 8);
        },
      ),
    );
  }
}
