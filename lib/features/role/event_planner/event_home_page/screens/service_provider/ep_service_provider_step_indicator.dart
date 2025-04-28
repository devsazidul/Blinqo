import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/ep_service_provider_controller/ep_service_provider_step_indicator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpServiceProviderStepIndicator extends StatelessWidget {
  final StepIndicatorController controller = Get.put(StepIndicatorController());

  final List<String> steps = ["Request", "Pending", "Confirmed", "Completed"];

  EpServiceProviderStepIndicator({super.key});
  final profileController = Get.put(ProfileController());

  Color getStepColor(int index, int currentStep) {
    return index < currentStep ? Colors.indigo[900]! : Colors.grey[300]!;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = profileController.isDarkMode.value;
    return Obx(() {
      int current = controller.currentStep.value;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(steps.length * 2 - 1, (index) {
              if (index.isEven) {
                int stepIndex = index ~/ 2;
                bool isCompleted = stepIndex < current;

                return Column(
                  children: [
                    // Text(
                    //   steps[stepIndex],
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     color:
                    //         isCompleted || isCurrent
                    //             ? Colors.indigo[900]
                    //             : Colors.grey,
                    //   ),
                    // ),
                    const SizedBox(height: 8),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor:
                          isCompleted
                              ? isDarkMode
                                  ? AppColors.buttonColor
                                  : Colors.indigo[900]
                              : Colors.grey[300],
                      child:
                          isCompleted
                              ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                              : null,
                    ),
                    const SizedBox(height: 6),
                  ],
                );
              } else {
                int lineIndex = (index - 1) ~/ 2;
                return Container(
                  width: 45,
                  height: 8,
                  color:
                      lineIndex < current
                          ? isDarkMode
                              ? AppColors.buttonColor
                              : Colors.indigo[900]
                          : Colors.grey[300],
                );
              }
            }),
          ),
        ],
      );
    });
  }
}
