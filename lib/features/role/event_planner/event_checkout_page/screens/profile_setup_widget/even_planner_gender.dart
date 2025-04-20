import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/common/styles/global_text_style.dart';
import '../controllers/even_profile_controller.dart';

class EvenPlannerGender extends StatelessWidget {
  EvenPlannerGender({super.key});
  final evenprofileController = Get.find<EvenProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        TextFormField(
          controller: evenprofileController.spnameController,
          decoration: InputDecoration(
            labelText: "Name",
            labelStyle: getTextStyle(
              fontSize: 16,
              color: AppColors.borderColor,
            ),
            hintText: "type your name",
            hintStyle: getTextStyle(fontSize: 14, color: AppColors.textColor),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 20),

        Obx(
          () => Container(
            width: double.infinity,
            height: 61,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderColor, width: 1),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 8, bottom: 9.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Gender',
                    style: getTextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 18,
                    child: PopupMenuButton<String>(
                      color: AppColors.primary,
                      onSelected:
                          (value) => evenprofileController.updateGender(value),
                      itemBuilder: (context) {
                        return evenprofileController.genders.map((role) {
                          return PopupMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList();
                      },
                      padding: EdgeInsets.zero,
                      offset: Offset(0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            evenprofileController.selectedGender.value,
                            style: getTextStyle(
                              fontSize: 16,
                              color: AppColors.borderColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset(
                              IconPath.arrowdown,
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
