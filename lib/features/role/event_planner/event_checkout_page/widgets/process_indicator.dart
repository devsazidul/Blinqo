import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';

class StepIndicatorController extends GetxController {
  // Set this to update current step (0 = Request, 1 = Pending, etc.)
  var currentStep = 2.obs;
}

class StepIndicator extends StatelessWidget {
  final StepIndicatorController controller = Get.put(StepIndicatorController());

  final List<String> steps = ["Request", "Pending", "Confirmed", "Completed"];

  StepIndicator({super.key});

  Color getStepColor(int index, int currentStep) {
    return index < currentStep ? Colors.indigo[900]! : Colors.grey[300]!;
  }

  @override
  Widget build(BuildContext context) {
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
                bool isCurrent = stepIndex == current;

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
                          isCompleted ? Colors.indigo[900] : Colors.grey[300],
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
                          ? Colors.indigo[900]
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
