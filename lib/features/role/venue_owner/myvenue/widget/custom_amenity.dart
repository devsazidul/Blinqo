import 'package:flutter/cupertino.dart';

import '../../../../../core/common/styles/global_text_style.dart';

class CustomAmenityBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final double heights;
  final double widths;


  const CustomAmenityBox({
    super.key,
    required this.icon,
    required this.label,
    required this.heights, required this.widths,


  });

  @override
  Widget build(BuildContext context) {
    return Container(
     height:heights ,
      width: widths,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1  ,
          color: const Color(0xffC0C0C0).withValues(alpha: 0.6),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 4),
          Icon( 
            icon,
            size: 18,
            color: const Color(0xffD4AF37),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xff333333),
            ),
          ),
        ],
      ),
    );
  }
}
