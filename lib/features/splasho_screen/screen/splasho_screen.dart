import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/splasho_screen/controller/splasho_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/utils/constants/icon_path.dart' show IconPath;

class SplashoScreen extends StatelessWidget {
  const SplashoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashoScreenController());

    return CupertinoPageScaffold(
      backgroundColor: AppColors.primary,
      child: Center(child: Image.asset(IconPath.splashframe, width: 148)),
    );
  }
}
