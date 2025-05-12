import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart' show AppColors;
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart' show ImagePath;
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/team/controller/teamcontroller.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/myteamedit.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/teaminformation.dart';
import 'package:blinqo/features/role/venue_owner/team/widget/contact_permission.dart';
import 'package:blinqo/features/role/venue_owner/team/widget/search_employee.dart'
    show SearchEmployee;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Myteam extends StatelessWidget {
  const Myteam({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Get.find() so you don't re-create controllers on rebuild
    final isDarkMode = Get.find<VenueOwnerProfileController>().isDarkMode.value;
    final TeamControllerGetx controller = Get.put(TeamControllerGetx());
    final searchEditing = TextEditingController();
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor:
          isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),

              // Search bar wired to controller.updateSearch
              SearchEmployee(
                controller: searchEditing,
                onChanged: controller.updateSearch,
              ),

              SizedBox(height: 40),

              // Total members count (always shows full list count)
              Obx(() {
                final total = controller.teamList.length;
                if (total == 0) return SizedBox();
                return Text(
                  '$total members',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffD4AF37),
                  ),
                );
              }),

              SizedBox(height: 8),

              // Filtered list display
              Obx(() {
                final list = controller.filteredTeamList;
                if (list.isEmpty) {
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
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (ctx, idx) {
                    final member = list[idx];
                    return Container(
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            isDarkMode ? Color(0xff32383D) : Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          color:
                              isDarkMode
                                  ? Color(0xff32383D)
                                  : Color(0xffEBEBEB),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Member name & role
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${member['firstName']} ${member['lastName']}',
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      isDarkMode
                                          ? Color(0xffEBEBEB)
                                          : Color(0xff333333),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                member['role'] ?? '',
                                style: getTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffA1A1A1),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),

                          // Edit button
                          InkWell(
                            onTap: () => Get.to(() => Myteamedit(index: idx)),
                            child: Icon(
                              Icons.edit_outlined,
                              size: 24,
                              color:
                                  isDarkMode
                                      ? Color(0xffD4AF37)
                                      : Color(0xff003366),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),

              SizedBox(height: screenHeight * 0.22),

              // Floating action button for adding members
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      context: context,
                      builder:
                          (_) => Container(
                            height: 195,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color:
                                  isDarkMode
                                      ? Color(0xff32383D)
                                      : Color(0xffE6EBF0),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 60,
                                  ),
                                  child: InkWell(
                                    onTap:
                                        () =>
                                            Get.to(() => EmployeeInformation()),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          IconPath.personadd,
                                          height: 16,
                                          width: 22,
                                          color:
                                              isDarkMode
                                                  ? Color(0xffD4AF37)
                                                  : Color(0xff003366),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Add team member manually',
                                          style: getTextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                isDarkMode
                                                    ? Color(0xffEBEBEB)
                                                    : Color(0xff333333),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: 22),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      final result = await pickContact(
                                        context,
                                      ); // ইউজার কাকে সিলেক্ট করলো সেটা ফেরত পাবে

                                      if (result != null) {
                                        controller.addTeamMembercontact(
                                          result,
                                        ); // টিম লিস্টে অ্যাড করে ফেলো
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          IconPath.contacts,
                                          height: 24,
                                          width: 24,
                                          color:
                                              isDarkMode
                                                  ? Color(0xffD4AF37)
                                                  : Color(0xff003366),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Add team member from contact',
                                          style: getTextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                isDarkMode
                                                    ? Color(0xffEBEBEB)
                                                    : Color(0xff333333),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    );
                  },
                  child: Container(
                    height: 46,
                    width: 53,
                    decoration: BoxDecoration(
                      color: Color(0xff003366),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
