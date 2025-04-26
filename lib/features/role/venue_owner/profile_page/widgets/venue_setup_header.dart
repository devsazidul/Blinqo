import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';


class VenueSetupHeader extends StatelessWidget {
  const VenueSetupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        ClipRRect(
          child: Stack(
            children: [
              Image.asset(
                ImagePath.venuesHall,
                width: double.infinity,
                height: screenHeight * 0.35,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                height: screenHeight * 0.35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0x00000000),
                      Color(0x00000000),
                      Color(0x00000000),
                      Color(0xFF161616),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          )
        ),
        Positioned(
          top: 60,
          left: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withAlpha(50),
              child: Icon(Icons.arrow_back, size: 24, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          top: 66,
          left: (screenWidth - 120) / 2,
          child: Text(
            'Venue Setup',
            style: getTextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Color(0xffD4AF37),
            radius: 18,
            child: Icon(
              Icons.mode_edit_outline_outlined,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }


}
