
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/edit_profile_page.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/profile_page.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/service_provider_profile.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/share_work_page.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/work_post_screen.dart';
import 'package:flutter/material.dart';

class SpProfile extends StatelessWidget {
  const SpProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        Widget screen;
        switch (settings.name) {
          case SpProfilePage.name:
            screen = SpProfilePage(); // sp profile settings
            break;
          case SpEditProfilePage.name:
            screen = SpEditProfilePage(); // sp edit profile
            break;
          case SpShareWorkPage.name:
            screen = SpShareWorkPage(); // sp share work
            break;
          case WorkPostScreen.name:
            screen = WorkPostScreen(); // sp works portfolio
            break;
          default:
            screen = ServiceProviderProfile(); // profile home page
            break;
        }
        return MaterialPageRoute(builder: (_) => screen);
      },
    );
  }
}
