import 'package:blinqo/core/common/models/sp_type_model.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/ep_common/widgets/ep_bottom_nav_bar_widget.dart';
import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_service_provider_list_controller.dart';
import 'package:blinqo/features/role/event_planner/ep_home/wigate/ep_service_provider_card.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpServiceProviderListScreen extends StatelessWidget {
  const EpServiceProviderListScreen({
    super.key,
    required this.serviceProviderTypeModel,
  });

  final ServiceProviderTypeModel serviceProviderTypeModel;

  @override
  Widget build(BuildContext context) {
    final EpServiceProviderListController epServiceDetailsController = Get.put(
      EpServiceProviderListController(),
    );

    final profileController = Get.put(ProfileController());
    bool isDarkMode = profileController.isDarkMode.value;

    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: _buildAppBar(context),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 20),

            // search options
            Row(
              children: [
                // search text field
                Expanded(
                  child: TextField(
                    controller: epServiceDetailsController.search,
                    onChanged: (value) {
                      epServiceDetailsController.searchQuery.value = value;
                    },
                    style: getTextStyle(
                      fontSize: 16,
                      color:
                          isDarkMode
                              ? AppColors.primary
                              : AppColors.subTextColor2,
                    ),
                    decoration: InputDecoration(
                      hintText: "Search Service Provider.......",
                      hintStyle: getTextStyle(
                        fontSize: 16,
                        color:
                            isDarkMode
                                ? AppColors.primary
                                : AppColors.subTextColor2,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 10.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor:
                          isDarkMode
                              ? AppColors.textFieldDarkColor
                              : AppColors.primary,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          epServiceDetailsController.searchQuery.value =
                              epServiceDetailsController.search.text;
                        },
                        child: Icon(
                          Icons.search,
                          color:
                              isDarkMode
                                  ? AppColors.buttonColor
                                  : AppColors.textColor,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                // filter button
                GestureDetector(
                  onTap: () {
                    // epServiceDetailsController.showFilterDialog(context);
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color:
                          isDarkMode
                              ? AppColors.textFieldDarkColor
                              : Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Image.asset(
                        IconPath.epsearchfilter,
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 33),

            // list view for all the users
            Expanded(
              child: GetBuilder<EpServiceProviderListController>(
                builder: (controller) {
                  if (controller.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (controller.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(
                        controller.errorMessage,
                        style: getTextStyle(fontSize: 16, color: Colors.red),
                      ),
                    );
                  }

                  final serviceUserModel = controller.spProfileModelList;
                  if (serviceUserModel == null || serviceUserModel.isEmpty) {
                    return Center(
                      child: Text(
                        'No data!',
                        style: getTextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: serviceUserModel.length,
                    itemBuilder: (context, index) {
                      final user = serviceUserModel[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: EpCustomServiceProviderCard(userModel: user),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: EpBottomNavBarWidget(),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: null,
        flexibleSpace: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: serviceProviderTypeModel.avatar?.path ?? '',
              fit: BoxFit.cover,
              width: MediaQuery.sizeOf(context).width,
            ),

            Positioned.fill(
              child: Container(color: Colors.black.withValues(alpha: 0.6)),
            ),
            Positioned(
              left: 20,
              top: 70,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.10),
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
                    serviceProviderTypeModel.name ?? '',
                    style: getTextStyle(
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
    );
  }
}
