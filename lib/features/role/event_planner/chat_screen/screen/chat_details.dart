import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_chat_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetails extends StatelessWidget {
  final EpChatScreenController epChatScreenController = Get.put(
    EpChatScreenController(),
  );
  ChatDetails({super.key});
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.chatBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        forceMaterialTransparency: false,
        leadingWidth: screenHeight * 0.04,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: screenHeight * 0.03),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(ImagePath.profile)),
            SizedBox(width: screenWidth * 0.023),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mia Wilson',
                  style: getTextStyle(
                    fontSize: screenHeight * 0.017,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  'Online',
                  style: getTextStyle(
                    fontSize: screenHeight * 0.015,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff008D36),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: AppColors.textColor,
              size: screenHeight * 0.035,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [searchBar(screenHeight), sendButton(screenHeight)],
      ),
    );
  }

  Widget searchBar(double screenHeight) {
    return Positioned(
      bottom: screenHeight * 0.02,
      left: screenHeight * 0.02,
      right: screenHeight * 0.09,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.insert_emoticon),
              color: AppColors.iconColor,
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: 'Type Message',
                  hintStyle: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintTextColor,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                maxLines: 1,
              ),
            ),
            IconButton(
              icon: Icon(Icons.link_sharp),
              color: AppColors.iconColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget sendButton(double screenHeight) {
    return Positioned(
      bottom: screenHeight * 0.023,
      right: screenHeight * 0.03,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.iconColor,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.send, color: AppColors.primary),
        ),
      ),
    );
  }
}
