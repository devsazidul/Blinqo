import 'package:blinqo/core/common/widgets/custom_appbar_widget.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/widget/f_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickColorScreen extends StatelessWidget {
  const PickColorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBarWidget(
        title: "Pick a Color",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: ColoredBox(
        color: AppColors.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder<PickColorController>(
            builder: (controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 160,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5, // Number of columns
                        mainAxisSpacing: 16, // Vertical spacing
                        crossAxisSpacing: 16,
                      ),
                      itemCount: controller.colorList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            // Handle color selection
                            // controller.changeColor(controller.colorList[index]);
                            controller.selectAColor(
                              controller.colorList[index],
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      controller
                                          .colorList[index], // Set the color for the box
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ), // Rounded corners
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(20),
                                      blurRadius: 4,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                              if (controller.selectColor ==
                                  controller.colorList[index])
                                Positioned(
                                  bottom: 8,
                                  left: 8,
                                  child: Image.asset(
                                    IconPath.checkCircle,
                                    width: 16,
                                    height: 16,
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 40),

                  //* Button
                  FCustomButton(
                    child: Text("Save"),
                    onPressed: () {
                      controller.changeColor(controller.selectColor);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
