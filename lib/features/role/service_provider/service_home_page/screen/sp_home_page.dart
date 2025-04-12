import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';

class SpHomePage extends StatelessWidget {
  const SpHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: false,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: Image.asset(IconPath.sphprofile, width: 40, height: 40),
            ),
            SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dianne Russell",
                  style: getTextStyle(
                    color: Color(0xFF082B09),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Venue Owner",
                  style: getTextStyle(
                    color: Color(0xFF898989),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                // Go Pro Button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 67,
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFF00BA0B)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Center(
                        child: Text(
                          'Go Pro',
                          style: getTextStyle(
                            color: Color(0xFF00BA0B),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Notification Bell Icon
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 16),
                // ListTile(
                //   leading: CircleAvatar(
                //     backgroundColor: Colors.grey.shade200,
                //     child: Image.asset(
                //       IconPath.sphprofile,
                //       width: 40,
                //       height: 40,
                //     ),
                //   ),
                //   title: Text(
                //     'Dianne Russell',
                //     style: getTextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
