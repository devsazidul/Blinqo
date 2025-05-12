import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../controllers/chat_controller.dart';
import '../controllers/group_controller.dart';

class GroupInfoView extends StatelessWidget {
  final String groupId;
  final GroupController groupController = Get.find<GroupController>();
  final ChatController chatController = Get.find<ChatController>();

  GroupInfoView({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final group = groupController.getGroupById(groupId);

    if (group == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Group Info'), elevation: 0),
        body: Center(child: Text('Group not found')),
      );
    }

    final members = groupController.getGroupMembers(groupId);
    final isCreator = group.creatorId == chatController.currentUser.value.id;

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xff151515) : Color(0xFFE6EBF0),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Group Info',
          style: getTextStyle(
            color: isDarkMode ? Color(0xffEBEBEB) : Colors.black,
            fontSize: 24,
          ),
        ),
        elevation: 0,
        backgroundColor: isDarkMode ? Color(0xff151515) : Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Color(0xffEBEBEB) : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Group image
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  group.avatar.startsWith('http')
                      ? NetworkImage(group.avatar)
                      : FileImage(File(group.avatar)) as ImageProvider,
            ),
            SizedBox(height: 16),

            // Group name
            Text(
              group.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Color(0xffEBEBEB) : Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${members.length} Members',
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Color(0xffC0C0C0) : Colors.grey[600],
              ),
            ),
            SizedBox(height: 24),

            // Add members button
            if (isCreator)
              ElevatedButton.icon(
                onPressed: () {
                  Get.snackbar(
                    'Coming Soon',
                    'Add members functionality will be available in the next update',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                icon: Icon(Icons.person_add),
                label: Text('Add Members'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0A2647),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            SizedBox(height: 24),

            // Members list
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Members',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Color(0xffEBEBEB) : Colors.black,
                    ),
                  ),
                  SizedBox(height: 12),
                  ...members.map(
                    (member) => _buildMemberItem(
                      member,
                      isCreator && member.id != group.creatorId,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Leave group button
            if (!isCreator)
              TextButton.icon(
                onPressed: () {
                  _showLeaveGroupConfirmation();
                },
                icon: Icon(Icons.exit_to_app, color: Colors.red),
                label: Text(
                  'Leave Group',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),

            // Delete group button (only for creator)
            if (isCreator)
              TextButton.icon(
                onPressed: () {
                  _showDeleteGroupConfirmation();
                },
                icon: Icon(Icons.delete_forever, color: Colors.red),
                label: Text(
                  'Delete Group',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberItem(User member, bool canRemove) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final isCurrentUser = member.id == chatController.currentUser.value.id;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(member.avatar),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${member.name} ${isCurrentUser ? '(You)' : ''}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Color(0xffEBEBEB) : Colors.black,
                  ),
                ),
                Text(
                  member.isOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                    fontSize: 12,
                    color: member.isOnline ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          if (canRemove)
            TextButton(
              onPressed: () {
                _showRemoveMemberConfirmation(member);
              },
              style: TextButton.styleFrom(
                backgroundColor:
                    isDarkMode ? Color(0xff151515) : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: isDarkMode ? Color(0xffABB7C2) : Colors.grey[200]!,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Remove',
                style: TextStyle(
                  color: isDarkMode ? Color(0xffEBEBEB) : Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showLeaveGroupConfirmation() {
    Get.dialog(
      AlertDialog(
        title: Text('Leave Group'),
        content: Text('Are you sure you want to leave this group?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              groupController.leaveGroup(groupId);
            },
            child: Text('Leave', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showDeleteGroupConfirmation() {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Group'),
        content: Text(
          'Are you sure you want to delete this group? This action cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              groupController.deleteGroup(groupId);
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showRemoveMemberConfirmation(User member) {
    Get.dialog(
      AlertDialog(
        title: Text('Remove Member'),
        content: Text(
          'Are you sure you want to remove ${member.name} from the group?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              groupController.removeMemberFromGroup(groupId, member.id);
            },
            child: Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
