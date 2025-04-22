import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;
  final Function(String)? onImageTap;
  final Function(String)? onAudioTap;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    this.onImageTap,
    this.onAudioTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        decoration: BoxDecoration(
          color:
              isCurrentUser ? AppColors.buttonColor2 : Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight:
                isCurrentUser
                    ? const Radius.circular(4)
                    : const Radius.circular(16),
            bottomLeft:
                !isCurrentUser
                    ? const Radius.circular(4)
                    : const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMessageContent(context),
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 4, left: 8),
              child: Text(
                ChatDateUtils.formatTime(message.timestamp.toInt()),
                style: getTextStyle(
                  fontSize: 12,
                  color:
                      isCurrentUser
                          ? Colors.white.withValues(alpha: 0.7)
                          : Colors.black.withValues(alpha: 0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    switch (message.type) {
      case MessageType.image:
        return GestureDetector(
          onTap:
              () =>
                  message.mediaUrl != null && onImageTap != null
                      ? onImageTap!(message.mediaUrl!)
                      : null,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child:
                message.mediaUrl != null
                    ? message.mediaUrl!.startsWith('http') ||
                            message.mediaUrl!.startsWith('file://')
                        ? Image.network(
                          message.mediaUrl!.replaceFirst('file://', ''),
                          width: 200,
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                width: 200,
                                height: 150,
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ),
                        )
                        : Image.file(
                          File(message.mediaUrl!),
                          width: 200,
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                width: 200,
                                height: 150,
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ),
                        )
                    : Container(
                      width: 200,
                      height: 150,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ),
          ),
        );

      case MessageType.audio:
        return GestureDetector(
          onTap:
              () =>
                  message.mediaUrl != null && onAudioTap != null
                      ? onAudioTap!(message.mediaUrl!)
                      : null,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isCurrentUser ? Colors.white : AppColors.iconColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    size: 16,
                    color: isCurrentUser ? AppColors.iconColor : Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 100,
                  child: Row(
                    children: List.generate(
                      8,
                      (index) => Container(
                        width: 3,
                        height: 4 + (index % 3) * 4.0,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color:
                              isCurrentUser
                                  ? Colors.white.withOpacity(
                                    0.2 + (index % 5) * 0.15,
                                  )
                                  : Colors.black.withOpacity(
                                    0.2 + (index % 5) * 0.15,
                                  ),
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  message.audioDuration ?? '0:00',
                  style: getTextStyle(
                    fontSize: 14,
                    color: isCurrentUser ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.only(
            right: 16,
            left: 16,
            top: 8,
            bottom: 2,
          ),
          child: Text(
            message.text,
            style: getTextStyle(
              fontSize: 16,
              color: isCurrentUser ? Colors.white : Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
    }
  }
}
