import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_chat_controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupProfile extends StatelessWidget {
  final EpChatController epChatController = Get.find<EpChatController>();
  final themeController = Get.find<SpProfileController>();

  GroupProfile({super.key, required this.chatId});
  final String chatId;

  @override
  Widget build(BuildContext context) {
    final user = epChatController.getUserById(chatId);

    return Obx(() {
      final themeMode =
          themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary.withValues(alpha: 0.1)
                              : AppColors.textColor.withValues(alpha: 0.15),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.primary
                                  : AppColors.textColor,
                        ),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 104,
                width: 104,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user?.avatar ?? ''),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: AppColors.appBarIcolor),
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Brithday Group',
                style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.borderColor2
                          : AppColors.textColor,
                ),
              ),
              SizedBox(height: 32),

              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: SizedBox(
                          height: 44,
                          width: 44,
                          child: Image.asset(
                            IconPath.addicon,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        'Add Members',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.borderColor2
                                  : AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      '44 Members',
                      style: getTextStyle(
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.smallText
                                : AppColors.subTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: 25,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index.isEven) {
                      return Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user?.avatar ?? ''),
                          ),
                          title: Text(
                            user?.name ?? '',
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color:
                                  themeMode == ThemeMode.dark
                                      ? AppColors.borderColor2
                                      : AppColors.textColor,
                            ),
                          ),
                          trailing: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.subTextColor2,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                'Remove',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      themeMode == ThemeMode.dark
                                          ? AppColors.borderColor2
                                          : AppColors.textColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 19, right: 22),
                          child: Divider(color: AppColors.subTextColor2),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
