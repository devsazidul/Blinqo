import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/show_profile_popup_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/image_path.dart';

class VenuePlaceholderWidget extends StatelessWidget {
  const VenuePlaceholderWidget({super.key});


  @override
  Widget build(BuildContext context) {
    VenueOwnerProfileController controller =Get.put(VenueOwnerProfileController());
    final bool isDarkMode =controller.isDarkMode.value;
    return Column(
      children: [
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * (232 / MediaQuery.of(context).size.height),
            width: MediaQuery.of(context).size.width * (232 / MediaQuery.of(context).size.width),
            child: Image.asset(ImagePath.emptyvenue, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            'It looks like no venue have been\nadded yet.',
            textAlign: TextAlign.center,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color:isDarkMode? Color(0xffEBEBEB) : Color(0xff333333),
            ),
          ),
        ),
      ],
    );
  }
}