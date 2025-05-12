import 'package:flutter/cupertino.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/image_path.dart';

class VenuePlaceholderWidget extends StatelessWidget {
  const VenuePlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
            height:
                MediaQuery.of(context).size.height *
                (232 / MediaQuery.of(context).size.height),
            width:
                MediaQuery.of(context).size.width *
                (232 / MediaQuery.of(context).size.width),
            child: Image.asset(ImagePath.emptyvenue, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            'It looks like no venue have been\n          added yet.',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff333333),
            ),
          ),
        ),
      ],
    );
  }
}
