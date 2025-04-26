import 'dart:io';
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/controllers/verification_submission_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoUploadWidget extends StatelessWidget {
  final String
  imageKey; // Identifier for the image (e.g., "national_id" or "business_cert")

  const PhotoUploadWidget({super.key, required this.imageKey});

  @override
  Widget build(BuildContext context) {
    final VerificationSubmissionController controller = Get.put(
      VerificationSubmissionController(),
    );
    final bool isDarkMode = controller.isDarkMode.value;

    return GestureDetector(
      onTap: () {
        debugPrint(
          "PhotoUploadWidget tapped for imageKey: $imageKey, calling pickImage...",
        );
        controller.pickImage(imageKey); // Pass the imageKey to pickImage
      },
      child: Obx(() {
        // Access the specific image using the imageKey
        final File? selectedImage = controller.images[imageKey]?.value;
        return ColoredBox(
          color: isDarkMode ? const Color(0xff32383D) : const Color(0xffFAFAFA),
          child: SizedBox(
            width: double.infinity,
            child:
                selectedImage == null
                    ? DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(8),
                      dashPattern: const [4, 4],
                      strokeCap: StrokeCap.round,
                      strokeWidth: 1.5,
                      padding: const EdgeInsets.all(16),
                      color: const Color(0xffE5E5E5),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(IconPath.niduploadlogo, height: 32),
                            const SizedBox(height: 12),
                            Text(
                              'Click to upload',
                              style: getTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff0EA5E9),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'JPG, JPEG, PNG less than 1MB',
                              style: getTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xffA3A3A3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        selectedImage,
                        fit: BoxFit.cover,
                        height: 150,
                        width: double.infinity,
                      ),
                    ),
          ),
        );
      }),
    );
  }
}
