import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/utils/constants/icon_path.dart' show IconPath;

class SplashoScreen extends StatelessWidget {
  const SplashoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      backgroundColor: AppColors.primary,
      child: Center(child: Image.asset(IconPath.logo, width: screenWidth * .7)),
    );
  }
}
