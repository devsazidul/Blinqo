import 'package:blinqo/features/role/venue_owner/venue_chat_page/screens/chat_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';

class UserProfileView extends StatelessWidget {
  final String userId;
  final ChatController chatController = Get.put(ChatController());

  UserProfileView({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = chatController.getUserById(userId);

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          elevation: 0,
        ),
        body: Center(
          child: Text('User not found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Chat'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Profile image
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user.avatar),
            ),
            SizedBox(height: 16),

            // Name and status
            Text(
              user.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              user.isOnline ? 'Online' : 'Offline',
              style: TextStyle(
                fontSize: 16,
                color: user.isOnline ? Colors.green : Colors.grey,
              ),
            ),
            SizedBox(height: 24),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(Icons.phone, Color(0xFF0A2647)),
                SizedBox(width: 32),
                _buildActionButton(Icons.videocam, Color(0xFF0A2647)),
                SizedBox(width: 32),
                _buildActionButton(Icons.notifications, Color(0xFF0A2647)),
              ],
            ),
            SizedBox(height: 32),

            // Message button
            ElevatedButton(
              onPressed: () {
                chatController.setActiveChat(userId);
                Get.off(() => ChatDetailView(chatId: userId));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0A2647),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Say hello to ${user.name}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 32),

            // Options
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildOptionItem(Icons.block, 'Block User'),
                  _buildOptionItem(Icons.flag, 'Report User'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey[600],
          ),
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}