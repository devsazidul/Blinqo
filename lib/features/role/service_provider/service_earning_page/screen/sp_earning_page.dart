import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/service_provider/service_earning_page/controller/sp_earning_controller.dart';
import 'package:blinqo/features/role/service_provider/service_earning_page/widget/custom_cashIn_card.dart';
import 'package:blinqo/features/role/service_provider/service_earning_page/widget/sp_custom_total_revenue_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../service_profile_page/controller/service_user_profile_controler.dart';

class SpEarningPage extends StatelessWidget {
  SpEarningPage({super.key});
  final SpEarningController spEarningController = Get.put(
    SpEarningController(),
  );

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpProfileController());
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor:
                  themeMode == ThemeMode.dark
                      ? AppColors.textColor
                      : AppColors.appBarIcolor,
              child: Image.asset(
                IconPath.arrowleft,
                width: 16,
                height: 12,
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.primary
                        : AppColors.textColor,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            "Earning",
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.primary
                      : AppColors.textColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              CustomTotalRevenueCard(
                totalRevenue: '1500',
                thisMonth: '4000',
                withdrawableBalance: '3000',
                growthRate: '15.5',
              ),
              SizedBox(height: 31),

              Obx(() {
                if (spEarningController.transactions.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: spEarningController.transactions.length,
                    itemBuilder: (context, index) {
                      var transaction = spEarningController.transactions[index];
                      return CustomCashInCard(
                        amount: transaction['amount']!,
                        transactionId: transaction['transactionId']!,
                        date: transaction['date']!,
                        time: transaction['time']!,
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
