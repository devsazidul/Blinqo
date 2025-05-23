import 'package:blinqo/core/common/models/sp_type_model.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_service_provider_list_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/ep_service_provider_list_screen.dart';

class EpServiceProviderTypeCard extends StatelessWidget {
  final ServiceProviderTypeModel spTypeMode;

  final bool isDark;

  const EpServiceProviderTypeCard({
    super.key,
    required this.spTypeMode,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final spListController = Get.put(EpServiceProviderListController());
    return GestureDetector(
      onTap: () async {
        await spListController.getSpProfileListByServiceTypeId(
          serviceId: spTypeMode.id.toString(),
        );
        Get.to(
          () =>
              EpServiceProviderListScreen(serviceProviderTypeModel: spTypeMode),
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: spTypeMode.avatar?.path.toString() ?? '',
              memCacheWidth: 168,
              memCacheHeight: 123,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) {
                return SizedBox();
              },
            ),
          ),
          Text(
            spTypeMode.name ?? '',
            style: GoogleFonts.poppins(
              color: isDark ? AppColors.backgroundColor : AppColors.textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Model for a service
class Service {
  final String imagePath;
  final String label;

  Service({required this.imagePath, required this.label});
}
