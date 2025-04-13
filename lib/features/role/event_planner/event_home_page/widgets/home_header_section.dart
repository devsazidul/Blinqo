import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';

class HomeHeaderSection extends StatelessWidget implements PreferredSizeWidget {
  final ThemeMode themeMode;
  const HomeHeaderSection({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SafeArea(
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(ImagePath.profile),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dianne Russell',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          themeMode == ThemeMode.dark
                              ? Color(0xffEBEBEB)
                              : AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Color(0xFFA1A1A1),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Wrap(
                          children: [
                            Text(
                              '45th Street, Los Angeles, USA',
                              // overflow: TextOverflow.,
                              style: getTextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: Color(0xFFA1A1A1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.all(10),
              ),
              onPressed: () {},
              child: Text(
                'Go Pro',
                style: getTextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.notifications, size: 24, color: AppColors.iconColor),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(65);
}
