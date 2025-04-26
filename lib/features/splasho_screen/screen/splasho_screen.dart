import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/splasho_screen/controller/splasho_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashoScreen extends StatelessWidget {
  const SplashoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashoScreenController());

    return CupertinoPageScaffold(
      backgroundColor: AppColors.primary,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImagePath.splashImage, width: 160),
            SizedBox(
              height: 20,
            ), 
            Text("Ventqo",
             style: GoogleFonts.sansitaSwashed(
                color: Color(0xFF003366), 
                fontSize: 48, 
                fontWeight: FontWeight.w700, 
                 decoration: TextDecoration.none,
             ),
            )
          ],
        )),
    );
  }
}
