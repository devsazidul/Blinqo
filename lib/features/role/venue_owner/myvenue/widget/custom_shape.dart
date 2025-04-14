import 'package:flutter/cupertino.dart';

import '../../../../../core/common/styles/global_text_style.dart';

class CustomShapeTag extends StatelessWidget {
  final String label;
  final double height;
  final double width;

  const CustomShapeTag({
    super.key,
    required this.label,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.3),
              blurRadius: 3,

            ),
          ],
          borderRadius: BorderRadius.circular(34),
          color: const Color(0xffFFFFFF),
        ),
        child: Center(
          child: Text(
            label,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xff333333),
            ),
          ),
        ),
      ),
    );
  }
}
