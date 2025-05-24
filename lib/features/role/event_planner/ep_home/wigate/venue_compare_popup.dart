import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_compare/screen/add_compare.dart';
import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_venue_compare_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueComparePopup extends StatelessWidget {
  const VenueComparePopup({super.key});

  @override
  Widget build(BuildContext context) {
    final venueCompareController = Get.find<EpVenueCompareController>();
    // print(venueCompareController.venues.length);
    return Container(
      width: MediaQuery.sizeOf(context).width / 2,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF003366), Color(0xFF729CC7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonColor2.withValues(alpha: 0.4),
            blurRadius: 100,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildVenueComparisonHeader(),
          const SizedBox(height: 8),
          _buildVenueList(venueCompareController),
          _buildCompareButton(),
        ],
      ),
    );
  }

  /// Builds the header section for the venue comparison container
  Widget _buildVenueComparisonHeader() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        'Venues',
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Builds the list of selected venues in the comparison container
  Widget _buildVenueList(EpVenueCompareController abcd) {
    return GetBuilder<EpVenueCompareController>(
      builder: (controller) {
        return Column(
          children: List.generate(
            controller.venues.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    child: ClipOval(
                      child: Image.network(
                        controller.venues[index].venueImage?.path ?? '',
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      controller.venues[index].name ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        overflow:
                            (controller.venues[index].name?.length ?? 0) > 16
                                ? TextOverflow.ellipsis
                                : null,
                      ),
                    ),
                  ),
                  // const Spacer(),
                  GestureDetector(
                    onTap:
                        () => controller.removeVenueFromCompare(
                          controller.venues[index].id ?? '',
                        ),
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      radius: 12,
                      child: ClipOval(
                        child: Image.asset(
                          IconPath.closesmallicon,
                          width: 6,
                          height: 6,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds the compare button in the venue comparison container
  Widget _buildCompareButton() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () => Get.to(AddCompare()),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Compare Now',
              style: getTextStyle(
                color: AppColors.buttonColor2,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(
              IconPath.rightarrow,
              width: 16,
              height: 16,
              fit: BoxFit.cover,
              color: AppColors.buttonColor2,
            ),
          ],
        ),
      ),
    );
  }
}
