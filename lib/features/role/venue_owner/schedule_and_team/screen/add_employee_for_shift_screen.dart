import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/controller/addshiftcontroller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/controller/shif_controller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/widget/search_employee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AddEmployeeForShift extends StatelessWidget {
  final String venueId;
  const AddEmployeeForShift({super.key, required this.venueId});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final Addshiftcontroller controller = Get.put(Addshiftcontroller());
    final TextEditingController search = TextEditingController();

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff151515) : AppColors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  // search employee
                  SearchEmployee(
                    controller: search,
                    onChanged: controller.updateSearch,
                  ),
                  const SizedBox(height: 20),
                  // show number of employees
                  Text(
                    '${controller.employees.length} Members',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffD4AF37),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Obx(
                      () =>
                          controller.employees.isEmpty
                              ? _buildShimmerLoading(isDarkMode)
                              : ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.filteredEmployees.length,
                                itemBuilder: (context, index) {
                                  final employee =
                                      controller.filteredEmployees[index];
                                  return _buildEmployeeCard(
                                    employee,
                                    index,
                                    controller,
                                    isDarkMode,
                                  );
                                },
                              ),
                    ),
                  ),
                  // Add extra padding at bottom for floating button
                  const SizedBox(height: 80),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: _buildAddEmployeeButton(controller, isDarkMode),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading(bool isDarkMode) {
    return Shimmer.fromColors(
      baseColor: isDarkMode ? const Color(0xff32383D) : Colors.grey[300]!,
      highlightColor: isDarkMode ? const Color(0xff404040) : Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            height: 80,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmployeeCard(
    dynamic employee,
    int index,
    Addshiftcontroller controller,
    bool isDarkMode,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xff32383D) : const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color:
                isDarkMode ? const Color(0xff32383D) : const Color(0xffEBEBEB),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.name,
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:
                          isDarkMode
                              ? const Color(0xffEBEBEB)
                              : const Color(0xff333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    employee.position,
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffA1A1A1),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Obx(
              () => Checkbox(
                side: BorderSide(
                  width: 1,
                  color:
                      isDarkMode
                          ? const Color(0xffD4AF37)
                          : const Color(0xff003366),
                ),
                activeColor:
                    isDarkMode
                        ? const Color(0xffD4AF37)
                        : const Color(0xff003366),
                value: employee.isChecked.value,
                onChanged: (value) => controller.toggleCheckbox(index, value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddEmployeeButton(
    Addshiftcontroller controller,
    bool isDarkMode,
  ) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              final selected =
                  controller.employees.where((e) => e.isChecked.value).toList();
              final shiftController = Get.find<ShiftController>();
                shiftController.setSelectedEmployees(selected);  
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: const Color(0xff003366)),
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xff003366),
              ),
              child: const Center(
                child: Text(
                  'Add Selected',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffF4F4F4),
                  ),
                ),
              ),
            ),
          ),
        ),

        // add employee
      ],
    );
  }
}
