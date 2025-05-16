import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_work_details_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/model/sp_works_model.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/sp_work_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpWorksCardWidget extends StatelessWidget {
  const SpWorksCardWidget({super.key, required this.spWorksModel});

  final SpWorksModel spWorksModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTapWorkCard(context, spWorksModel.id ?? ''),
      child: Card(
        elevation: 4, // Adds shadow for the card effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        child: Container(
          height: 150, // Adjust height as needed
          width: double.infinity, // Adjust width as needed

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(
                spWorksModel.files?[0].path ?? "",
              ), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // Overlay for better text readability
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withAlpha(100), // Top is slightly darker
                      Colors.black.withAlpha(100), // Bottom is darker
                    ],
                  ),
                ),
              ),
              // Text content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spWorksModel.projectTitle ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      SpAuthController.spUser?.name ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFD4AF37),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapWorkCard(BuildContext context, String workId) async {
    await Get.find<SpWorkDetailsController>().getWorkDetails(workId);
    Navigator.pushNamed(
      // ignore: use_build_context_synchronously
      context,
      SpWorkDetailsScreen.name,
      arguments: spWorksModel,
    );
  }
}
