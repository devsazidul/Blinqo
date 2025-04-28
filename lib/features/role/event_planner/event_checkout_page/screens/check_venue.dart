import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/controllers/checklist_controller.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/build_checkappbar.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/widgets/ep_custom_check_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CheckVenue extends StatelessWidget {
  final String eventName;
  final String taskName;
  final String selectedDate;
  final String selectedTime;

  const CheckVenue({
    super.key,
    required this.eventName,
    required this.taskName,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final checklistController = Get.find<ChecklistController>(); // ✅ Get the correct controller

    // Dropdown value variable
    Rx<String> dropdownValue = 'All Task'.obs;
    Rx<String> dropdown = 'By Date'.obs;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildCheckVenueAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // First Dropdown: "All Task" or "Urgent"
                  Container(
                    height: 36,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Color(0xffE6EBF0),
                      borderRadius: BorderRadius.circular(8),
                      // Removed the top border, keeping only bottom and side borders
                      border: Border.all(
                        width: 1,
                        color: Color(0xff003366),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        value: dropdownValue.value,
                        icon: Image.asset(
                          IconPath.dropdown,
                          height: 7,
                          width: 11,
                        ),
                        isExpanded: true, // Expand to fit the container
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            dropdownValue.value = newValue;
                          }
                        },
                        items: <String>['All Task', 'Urgent']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(width: 17),
                  // Second Dropdown: "By Date"
                  Container(
                    height: 36,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Color(0xffE6EBF0),
                      borderRadius: BorderRadius.circular(8),
                      // Same change to avoid the straight line
                      border: Border.all(
                        width: 1,
                        color: Color(0xff003366),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        value: dropdown.value,
                        icon: Image.asset(
                          IconPath.dropdown,
                          height: 7,
                          width: 11,
                        ),
                        isExpanded: true, // Expand to fit the container
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            dropdown.value = newValue;
                          }
                        },
                        items: <String>['By Date']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: checklistController.checklistItems.length,
                  itemBuilder: (context, index) {
                    final item = checklistController.checklistItems[index];
                    return EpCustomCheckListWidget(item: item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
