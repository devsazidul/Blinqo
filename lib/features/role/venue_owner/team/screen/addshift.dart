import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/team/controller/addshiftcontroller.dart';
import 'package:blinqo/features/role/venue_owner/team/controller/shifcontroller.dart';
import 'package:blinqo/features/role/venue_owner/team/widget/search_employee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Addshift extends StatelessWidget {
  const Addshift({super.key});
  @override
  Widget build(BuildContext context) {
    final Addshiftcontroller controller = Get.put(Addshiftcontroller());
    TextEditingController search = TextEditingController();
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                SearchEmployee(controller: search),
                SizedBox(height: 20),
                Text(
                  '${controller.employees.length} Members', // Dynamically show the number of employees
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffD4AF37),
                  ),
                ),
                SizedBox(height: 8),
                // Dynamic list of employees
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.employees.length,
                    itemBuilder: (context, index) {
                      final employee = controller.employees[index];
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: 1,
                                color: Color(0xffEBEBEB),
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        employee.name,
                                        style: getTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff333333),
                                        ),
                                      ),
                                      SizedBox(height: 4, width: 4),
                                      Text(
                                        employee.position,
                                        style: getTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xffA1A1A1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Obx(
                                  () => Checkbox(
                                    side: BorderSide(
                                      width: 1,
                                      color: Color(0xff003366),
                                    ),
                                    activeColor: Color(0xff003366),
                                    value: employee.isChecked.value,
                                    onChanged:
                                        (value) => controller.toggleCheckbox(
                                          index,
                                          value,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // 8px vertical spacing between each container
                          SizedBox(height: 8),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    final selected =
                        controller.employees
                            .where((e) => e.isChecked.value)
                            .toList();

                    // Get the main shift controller and pass selected data
                    final shiftController = Get.find<ShiftController>();
                    shiftController.setSelectedEmployees(selected);

                    // Go back to Createshift
                    Get.back();
                  },
                  child: Container(
                    width: double.infinity,
                    height: screenHeight * 0.080,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xff003366)),
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xff003366),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add Employee ',
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffF4F4F4),
                            ),
                          ),
                          SizedBox(width: 15),
                          Icon(Icons.add, size: 16, color: Color(0xffF4F4F4)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 58),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
