import 'package:blinqo/features/role/service_provider/service_chat_page/screen/sp_single_page_chat.dart'
    show SpSinglePageChat;
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/service_chat_page/controller/sp_chat_controller.dart';
import 'package:blinqo/features/role/service_provider/service_chat_page/widget/sp_custom_chat_list.dart';

class SpChatPage extends StatelessWidget {
  SpChatPage({super.key});
  final controller = Get.put(SpProfileController());
  final SpChatController spChatController = Get.put(SpChatController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
        appBar: AppBar(
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Chat",
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.primary
                      : AppColors.textColor,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                controller.toggleDarkMode();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.dark_mode,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.primary
                          : AppColors.textColor,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: spChatController.chats.length,
            itemBuilder: (context, index) {
              final chat = spChatController.chats[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => SpSinglePageChat(chat: chat));
                },
                child: SpCustomChatList(
                  imagePath: chat['image'] ?? '',
                  name: chat['name'] ?? '',
                  lastMessage: chat['message'] ?? '',
                  time: chat['time'] ?? '',
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
