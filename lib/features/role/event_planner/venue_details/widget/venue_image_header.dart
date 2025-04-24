import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';

class VenueImageHeader extends StatelessWidget {
  final VoidCallback onBackTap;
  const VenueImageHeader({Key? key, required this.onBackTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Image.asset(
          ImagePath.venuesHall,
          width: double.infinity,
          height: screenHeight * 0.4,
          fit: BoxFit.cover,
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xff161616),
                  Color(0xff000000).withOpacity(0.1),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 24,
                  top: 40,
                  child: GestureDetector(
                    onTap: onBackTap,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0x1A333333).withAlpha(25),
                      child: Image.asset(
                        IconPath.arrowLeftAlt,
                        width: 16,
                        height: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 46,
                  right: 24,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xff333333).withAlpha(25),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      IconPath.love,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 26,
                  right: 26,
                  child: Image.asset(
                    IconPath.rotatevenue,
                    width: 26,
                    height: 19,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
