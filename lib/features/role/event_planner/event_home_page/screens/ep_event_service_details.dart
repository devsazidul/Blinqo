import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/ep_event_service_details_controller.dart';

import 'package:blinqo/features/role/event_planner/event_home_page/widgets/ep_service_provider_card.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/event_services_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpEventServiceDetails extends StatelessWidget {
  EpEventServiceDetails({super.key, required this.service});
  final Service service;
  final EpEventServiceDetailsController epServiceDetailsController = Get.put(
    EpEventServiceDetailsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(service.imagePath, fit: BoxFit.cover),
              ),
              Positioned.fill(
                child: Container(
                  color: AppColors.textColor.withValues(alpha: 0.6),
                ),
              ),
              Positioned(
                left: 20,
                top: 70,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.4),
                    child: Image.asset(
                      IconPath.arrowleftwhite,
                      width: 22,
                      height: 16,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 30,
                bottom: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      service.label,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          centerTitle: false,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: epServiceDetailsController.search,
                    onChanged: (value) {
                      epServiceDetailsController.searchQuery.value = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Search Service Provider.......",
                      hintStyle: getTextStyle(
                        fontSize: 16,
                        color: AppColors.subTextColor2,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 10.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.primary,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          epServiceDetailsController.searchQuery.value =
                              epServiceDetailsController.search.text;
                        },
                        child: Image.asset(
                          IconPath.epsearch,
                          width: 18,
                          height: 18,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),

                // GestureDetector(
                //   onTap: () {
                //     // epServiceDetailsController.showFilterDialog(context);
                //   },
                //   child: Container(
                //     width: 48,
                //     height: 48,
                //     decoration: BoxDecoration(
                //       color: AppColors.appBarArrowIconColor,
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: Center(
                //       child: Image.asset(
                //         IconPath.epsearchfilter,
                //         width: 18,
                //         height: 18,
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 33),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: epServiceDetailsController.serviceProviders.length,
                  itemBuilder: (context, index) {
                    final provider =
                        epServiceDetailsController.serviceProviders[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: EpCustomServiceProdiverCard(
                        provider: provider.cast<String, Object>(),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
