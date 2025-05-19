import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart' show AppColors;
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart' show ImagePath;
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/controller/my_team_tab_controller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/screen/create_employee_screen.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/widget/contact_permission.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/widget/search_employee.dart'
    show SearchEmployee;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class MyTeamTab extends StatelessWidget {
  final String venueId;
  const MyTeamTab({super.key, required this.venueId});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.find<VenueOwnerProfileController>().isDarkMode.value;
    final MyTeamTabController controller = Get.put(MyTeamTabController());
    final searchEditing = TextEditingController();
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff151515) : AppColors.backgroundColor,
      floatingActionButton: _buildFloatingActionButton(context, isDarkMode),
      // left side upper corner
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                // search employee
                SearchEmployee(
                  controller: searchEditing,
                  onChanged: controller.updateSearch,
                ),
                const SizedBox(height: 40),
                // shimmer loading
                if (controller.teamList.isEmpty)
                  _buildShimmerLoading(isDarkMode)
                else
                  _buildTeamContent(controller, isDarkMode),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff003366), Color(0xff0055a5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff003366).withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () => _showAddTeamMemberBottomSheet(context, isDarkMode),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  // shimmer loading
  Widget _buildShimmerLoading(bool isDarkMode) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Shimmer.fromColors(
            baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
            highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xff32383D) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 1,
                  color:
                      isDarkMode
                          ? const Color(0xff32383D)
                          : const Color(0xffEBEBEB),
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 120, height: 14, color: Colors.white),
                      const SizedBox(height: 4),
                      Container(width: 80, height: 12, color: Colors.white),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // team content
  Widget _buildTeamContent(MyTeamTabController controller, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${controller.teamList.length} members',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xffD4AF37),
          ),
        ),
        const SizedBox(height: 8),

        controller.filteredTeamList.isEmpty
            ? _buildEmptyState()
            : _buildTeamList(controller, isDarkMode),
      ],
    );
  }

  // empty state
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70),
        child: Image.asset(
          ImagePath.emptyTeam,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTeamList(MyTeamTabController controller, bool isDarkMode) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.filteredTeamList.length,
      itemBuilder: (ctx, idx) {
        final member = controller.filteredTeamList[idx];
        return _buildTeamMemberCard(member, idx, isDarkMode);
      },
    );
  }

  Widget _buildTeamMemberCard(dynamic member, int idx, bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xff32383D) : const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: isDarkMode ? const Color(0xff32383D) : const Color(0xffEBEBEB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with name and actions
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${member.firstName ?? ''} ${member.lastName ?? ''}',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:
                            isDarkMode
                                ? const Color(0xffEBEBEB)
                                : const Color(0xff333333),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      member.role ?? 'Unknown Role',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffD4AF37),
                      ),
                    ),
                  ],
                ),
              ),
              // Action buttons row
              Row(
                children: [
                  // Delete button
                  InkWell(
                    onTap:
                        () => _showDeleteConfirmationDialog(
                          member,
                          idx,
                          isDarkMode,
                        ),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      size: 22,
                      color:
                          isDarkMode
                              ? const Color(0xffD4AF37)
                              : const Color(0xff003366),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Edit button
                  InkWell(
                    onTap:
                        () => Get.to(
                          () => CreateEmployeeScreen(
                            venueId: venueId,
                            isEdit: true,
                            index: idx,
                          ),
                          arguments: {'isEdit': true, 'index': idx},
                        ),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 22,
                      color:
                          isDarkMode
                              ? const Color(0xffD4AF37)
                              : const Color(0xff003366),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Contact information
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  isDarkMode
                      ? const Color(0xff2A2F34)
                      : const Color(0xffF8F9FA),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                // Email row
                Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      size: 16,
                      color:
                          isDarkMode
                              ? const Color(0xffA1A1A1)
                              : const Color(0xff666666),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        member.email ?? 'No email provided',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color:
                              isDarkMode
                                  ? const Color(0xffA1A1A1)
                                  : const Color(0xff666666),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Phone row
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: 16,
                      color:
                          isDarkMode
                              ? const Color(0xffA1A1A1)
                              : const Color(0xff666666),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        member.phone ?? 'No phone provided',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color:
                              isDarkMode
                                  ? const Color(0xffA1A1A1)
                                  : const Color(0xff666666),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Delete confirmation dialog
  void _showDeleteConfirmationDialog(dynamic member, int idx, bool isDarkMode) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: Get.width * 0.85,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xff32383D) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      isDarkMode
                          ? const Color(0xffD4AF37).withValues(alpha: 0.1)
                          : const Color(0xff003366).withValues(alpha: 0.1),
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  size: 32,
                  color:
                      isDarkMode
                          ? const Color(0xffD4AF37)
                          : const Color(0xff003366),
                ),
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                'Delete Team Member',
                style: getTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color:
                      isDarkMode
                          ? const Color(0xffEBEBEB)
                          : const Color(0xff333333),
                ),
              ),
              const SizedBox(height: 12),
              // Message
              Text(
                'Are you sure you want to delete ${member.firstName} ${member.lastName} from your team?',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color:
                      isDarkMode
                          ? const Color(0xffA1A1A1)
                          : const Color(0xff666666),
                ),
              ),
              const SizedBox(height: 24),
              // Buttons row
              Row(
                children: [
                  // Cancel button
                  Expanded(
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color:
                                isDarkMode
                                    ? const Color(0xffD4AF37)
                                    : const Color(0xff003366),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color:
                                  isDarkMode
                                      ? const Color(0xffD4AF37)
                                      : const Color(0xff003366),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Delete button
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        Get.find<MyTeamTabController>().deleteTeamMember(idx);

                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [Color(0xff003366), Color(0xff0055a5)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Yes, Delete',
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddTeamMemberBottomSheet(BuildContext context, bool isDarkMode) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      context: context,
      builder:
          (_) => Container(
            height: 195,
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  isDarkMode
                      ? const Color(0xff32383D)
                      : const Color(0xffE6EBF0),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildBottomSheetOption(
                  icon: IconPath.personadd,
                  title: 'Add team member manually',
                  onTap:
                      () => Get.to(
                        () => CreateEmployeeScreen(
                          venueId: venueId,
                          isEdit: false,
                          index: 0,
                        ),
                        arguments: {'isEdit': false, 'index': 0},
                      ),
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 22),
                _buildBottomSheetOption(
                  icon: IconPath.contacts,
                  title: 'Add team member from contact',
                  onTap: () async {
                    final result = await pickContact(context);
                    if (result != null) {
                      Get.find<MyTeamTabController>().addTeamMembercontact(
                        result,
                        venueId,
                      );
                    }
                  },
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildBottomSheetOption({
    required String icon,
    required String title,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 24,
              width: 24,
              color:
                  isDarkMode
                      ? const Color(0xffD4AF37)
                      : const Color(0xff003366),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color:
                    isDarkMode
                        ? const Color(0xffEBEBEB)
                        : const Color(0xff333333),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
