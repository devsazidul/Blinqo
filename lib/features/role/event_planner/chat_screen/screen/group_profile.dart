import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/profile/widget/f_custom_button.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_chat_controller.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_create_group_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupProfile extends StatelessWidget {
  final EpChatController epChatController = Get.find<EpChatController>();
  final ProfileController themeController = Get.put(ProfileController());
  final EpCreateGroupController epCreateGroupController = Get.put(
    EpCreateGroupController(),
  );
  // final EpGroupController epGroupController = Get.put(EpGroupController());

  GroupProfile({super.key, required this.chatId});
  final String chatId;
  // final String groupId;

  @override
  Widget build(BuildContext context) {
    final user = epChatController.getUserById(chatId);

    bool isDarkMode = themeController.isDarkMode.value;

    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      body: SafeArea(
        child: GetBuilder<EpCreateGroupController>(
          builder: (controller) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            isDarkMode
                                ? AppColors.primary.withValues(alpha: 0.1)
                                : AppColors.textColor.withValues(alpha: 0.15),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color:
                                isDarkMode
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

                ///* ---------------- user name
                Text(
                  user?.name ?? '',
                  style: getTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color:
                        isDarkMode
                            ? AppColors.borderColor2
                            : AppColors.textColor,
                  ),
                ),
                SizedBox(height: 32),

                ///* ---------------- add members
                GestureDetector(
                  onTap: () => Get.dialog(_openAddMembersDialog()),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Image.asset(
                          IconPath.addicon,
                          fit: BoxFit.cover,
                          width: 24,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Add Members',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color:
                              isDarkMode
                                  ? AppColors.borderColor2
                                  : AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                ///* ---------------- members count
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        '${controller.groupUsers[chatId]?.length} Members',
                        style: getTextStyle(
                          color:
                              isDarkMode
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

                ///* ---------------- members list
                Expanded(
                  child: GetBuilder<EpCreateGroupController>(
                    builder: (epController) {
                      return ListView.builder(
                        itemCount: epController.groupUsers[chatId]?.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // if (index.isEven) {
                          User? groupUser = epChatController.getUserById(
                            epController.groupUsers[chatId]![index],
                          );
                          return Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  groupUser?.avatar ?? '',
                                ),
                              ),
                              title: Text(
                                groupUser?.name ?? '',
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isDarkMode
                                          ? AppColors.borderColor2
                                          : AppColors.textColor,
                                ),
                              ),
                              trailing: Padding(
                                padding: EdgeInsets.all(9),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.subTextColor2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      // epController.removeUserFromGroup(
                                      //   chatId,
                                      //   index,
                                      // );

                                      controller.groupUsers[chatId]?.removeAt(
                                        index,
                                      );
                                      epController.update();
                                    },
                                    child: Text(
                                      'Remove',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            isDarkMode
                                                ? AppColors.borderColor2
                                                : AppColors.textColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                          // } else {
                          //   return SizedBox(
                          //     height: 2,
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(left: 19, right: 22),
                          //       child: Divider(color: AppColors.subTextColor2),
                          //     ),
                          //   );
                          // }
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  AlertDialog _openAddMembersDialog() {
    final epCreateGroupController = Get.put(EpCreateGroupController());
    epCreateGroupController.selectedMembers.clear();
    final existingUserIds =
        epCreateGroupController.groupUsers[chatId]
            ?.map((e) => e.toString())
            .toList() ??
        [];
    final existingGroupIds = epCreateGroupController.groupUsers.keys.toList();

    return AlertDialog(
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Users list
            for (int i = 0; i < epChatController.users.length; i++)
              if (!existingUserIds.contains(epChatController.users[i].id) &&
                  !existingGroupIds.contains(epChatController.users[i].id))
                Obx(() {
                  return ListTile(
                    onTap: () {
                      if (epCreateGroupController.selectedMembers.contains(
                        epChatController.users[i].id,
                      )) {
                        epCreateGroupController.selectedMembers.remove(
                          epChatController.users[i].id,
                        );
                      } else {
                        epCreateGroupController.selectedMembers.add(
                          epChatController.users[i].id,
                        );
                      }
                    },
                    tileColor:
                        epCreateGroupController.selectedMembers.contains(
                              epChatController.users[i].id,
                            )
                            ? Color(0xFF003366).withAlpha(50)
                            : Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    leading: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.grey[300],
                      child: ClipOval(
                        child: Image.network(
                          epChatController.users[i].avatar,
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(epChatController.users[i].name),

                    trailing: Obx(() {
                      return epCreateGroupController.selectedMembers.contains(
                            epChatController.users[i].id,
                          )
                          ? Icon(Icons.check, color: Colors.white)
                          : Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.add, color: Colors.white),
                          );
                    }),
                  );
                }),

            /// Elevated Button
            SizedBox(height: 20),
            FCustomButton(
              child: Text("Add Members"),

              onPressed: () {
                epCreateGroupController.groupUsers[chatId]?.addAll(
                  epCreateGroupController.selectedMembers.toList(),
                );
                epCreateGroupController.update();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
