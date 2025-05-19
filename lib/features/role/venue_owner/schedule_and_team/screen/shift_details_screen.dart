import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/model/shift_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShiftDetailsScreen extends StatelessWidget {
  final ShiftData shift;

  const ShiftDetailsScreen({super.key, required this.shift});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;

    return Scaffold(
      backgroundColor:
          isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
        elevation: 0,
        title: Text('Shift Details'),
        centerTitle: true,
        titleTextStyle: getTextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                _buildInfoCard(
                  title: 'Shift Name',
                  value: shift.shiftName,
                  isDarkMode: isDarkMode,
                ),
                SizedBox(height: 16),
                _buildInfoCard(
                  title: 'Time',
                  value:
                      '${shift.startTime.hour.toString().padLeft(2, '0')}:${shift.startTime.minute.toString().padLeft(2, '0')} - ${shift.endTime.hour.toString().padLeft(2, '0')}:${shift.endTime.minute.toString().padLeft(2, '0')}',
                  isDarkMode: isDarkMode,
                ),
                SizedBox(height: 16),
                _buildInfoCard(
                  title: 'Duration',
                  value: '${shift.duration ~/ 60}h ${shift.duration % 60}m',
                  isDarkMode: isDarkMode,
                ),
                SizedBox(height: 16),
                _buildInfoCard(
                  title: 'Venue',
                  value: shift.venue.name,
                  isDarkMode: isDarkMode,
                ),
                SizedBox(height: 32),
                Text(
                  'Employees (${shift.employee.length})',
                  style: getTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                  ),
                ),
                SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: shift.employee.length,
                  itemBuilder: (context, index) {
                    final employee = shift.employee[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Color(0xff32383D) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              isDarkMode
                                  ? Color(0xff32383D)
                                  : Color(0xffEBEBEB),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${employee.firstName} ${employee.lastName}',
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:
                                  isDarkMode
                                      ? Color(0xffEBEBEB)
                                      : Color(0xff333333),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            employee.role,
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffA1A1A1),
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                size: 16,
                                color:
                                    isDarkMode
                                        ? Color(0xffD4AF37)
                                        : Color(0xff003366),
                              ),
                              SizedBox(width: 8),
                              Text(
                                employee.email,
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      isDarkMode
                                          ? Color(0xffC0C0C0)
                                          : Color(0xff5C5C5C),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.phone_outlined,
                                size: 16,
                                color:
                                    isDarkMode
                                        ? Color(0xffD4AF37)
                                        : Color(0xff003366),
                              ),
                              SizedBox(width: 8),
                              Text(
                                employee.phone,
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      isDarkMode
                                          ? Color(0xffC0C0C0)
                                          : Color(0xff5C5C5C),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required bool isDarkMode,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xff32383D) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Color(0xff32383D) : Color(0xffEBEBEB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Color(0xffA1A1A1) : Color(0xff5C5C5C),
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: getTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
            ),
          ),
        ],
      ),
    );
  }
}
